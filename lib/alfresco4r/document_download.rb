################################################################################
# File:  document_download.rb
# Author:Sivaprakasam Boopathy
# Date:  May 17, 2012
# Description: This file gives ability to download document from Alfresco
################################################################################

require 'alfresco4r'

module Alfresco4r
  class DocumentDownload < AbstractAlfrescoService
    EXPECTED_PARAMS = [:download_url,:node]

    attr_reader :data_stream

    def initialize(options)
      @options = options
      return verify_params if verify_params.kind_of?(Alfresco4r::AlfError)
      super
      download_document
    end

    def verify_params
      begin
        raise "Empty Parameter"  if @options.empty?
        missing_params = EXPECTED_PARAMS - @options.keys
        unless missing_params.empty?
          msg = "Expected paramerter #{missing_params} are missing. Expected parameters are :download_url,:node"
          raise "#{msg}"
        end
      rescue => e
        @res_obj = Alfresco4r::AlfError.new(e.message)
      end
    end

    def download_document
      begin
        @http.request(@request) do |response|
          @data_stream = response.read_body
        end
        @http.finish if @http.started?
        @res_obj = Alfresco4r::AlfSucessStream.new(@data_stream)
      rescue => e
        @res_obj = Alfresco4r::AlfError.new(e.message)
      end
    end

    def response
      return @res_obj
    end


  end
end

