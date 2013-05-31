################################################################################
# File:  document_upload.rb
# Author:Sivaprakasam Boopathy
# Date:  May 17, 2012
# Description: This file gives ability to upload document to Alfresco
################################################################################

require 'json'

module Alfresco4r
  class DocumentUpload < AbstractAlfrescoService
     EXPECTED_PARAMS = [:siteid,:containerid,:uploaddirectory,:mime_type,:full_file_name,:filedata,:upload_url]


    def initialize(options)
      @options = options
      return verify_params if verify_params.kind_of?(Alfresco4r::AlfError)
      @siteid = siteid
      @containerid = containerid
      @uploaddirectory = uploaddirectory
      @filedata = filedata
      @mime_type = mime_type
      @full_file_name = full_file_name
      @form_params = Array.new
      super
      upload_document
    end

    def verify_params
      begin
        raise "Empty Parameter"  if @options.empty?
        missing_params = EXPECTED_PARAMS - @options.keys
        unless missing_params.empty?
          msg = "Expected paramerter #{missing_params} are missing. Expected parameters are siteid,containerid,uploaddirectory,mime_type,full_file_name,filedata."
          raise "#{msg}"
        end
      rescue => e
        @res_obj = Alfresco4r::AlfError.new(e.message)
      end
    end



    def encode_form_data
      parameters = { 'siteid' => siteid, 'containerid' => containerid, 'uploaddirectory' => uploaddirectory }
      parameters.each do |key, value|
        unless value.empty?
          @form_params << "--" + BOUNDARY + "\r\n"
          @form_params << "Content-Disposition: form-data; name=\"#{key}\"\r\n" + "\r\n" + "#{value}\r\n"
        end
      end
      @form_params << "--" + BOUNDARY
    end

    def encode_file_data
      @form_params << ("\r\nContent-Disposition: form-data; name=\"filedata\"; filename=\"#{full_file_name}\"\r\n" + "Content-Transfer-Encoding: binary\r\n" + "Content-Type:" + "#{mime_type}" + "\r\n\r\n" + filedata + "\r\n")
      @form_params << "--" + BOUNDARY + "--"
    end



    def upload_document
      begin
        encode_form_data
        encode_file_data
        @request.body= @form_params.join
        @request["Content-Length"] = @request.body.length
        @request["Content-Type"] = "multipart/form-data, boundary=" + BOUNDARY
        res = Net::HTTP.new(@uri.host, @uri.port).start {|http| http.request(@request) }
        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
          json_obj = JSON.parse(res.body)
          @res_obj = Alfresco4r::AlfSucess.new(json_obj["nodeRef"],json_obj["fileName"],json_obj["status"]["description"])
        else
          @res_obj = Alfresco4r::AlfError.new("Exception in response body #{res.inspect}")
        end
      rescue => e
        @res_obj = Alfresco4r::AlfUnknownException.new(e.message)
      end

    end

    def response
      return @res_obj
    end


  end
end
