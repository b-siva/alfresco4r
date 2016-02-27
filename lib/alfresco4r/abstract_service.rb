require 'net/http'
require 'uri'
require 'yaml'

module Alfresco4r
  class AbstractAlfrescoService
    BOUNDARY = "AaB03x"
    attr_reader :options,:request,:uri,:http

    def initialize(options)
      @options = options
      self_class = self.class.name
      klass_url = self_class.concat("Url")
      @auth_obj = DocumentAuth.new(options)
      @url_obj = klass_url == "Alfresco4r::DocumentDownloadUrl" ? DocumentDownloadUrl.new(options) : DocumentUploadUrl.new(options)
      self_class.include?('Upload') ? post_object : get_object
    end

    def post_object
      @uri = URI(@url_obj.url)
      @request = Net::HTTP::Post.new(@uri.path)
      @request.basic_auth @auth_obj.username, @auth_obj.password
    end

    def get_object
     @uri = URI(@url_obj.url(node))
     @uri.query = URI.encode_www_form( { :a => 'true' } )
     @http = Net::HTTP.new(@uri.host, @uri.port)
     @request = Net::HTTP::Get.new(@uri.request_uri)
     @request.basic_auth @auth_obj.username, @auth_obj.password
    end

    def siteid
      @siteid = options[:siteid]
    end

    def containerid
      @containerid = options[:containerid]
    end

    def uploaddirectory
      @uploaddirectory = options[:uploaddirectory]
    end

    def filedata
      @filedata = options[:filedata]
    end

    def mime_type
      @mime_type = options[:mime_type]
    end

    def full_file_name
      @full_file_name = options[:full_file_name]
    end

    def node
      @node = options[:node]
    end


  end

  class DocumentAuth
    def initialize(options)
      @options = options
    end

    def username
      username = @options.has_key?(:username) ? @options[:username] : ""
      return username
    end

    def password
      password = @options.has_key?(:password) ? @options[:password] : ""
      return password
    end
  end

  class DocumentUploadUrl
    def initialize(options)
      @options = options
    end

    def url
      upload_url = @options[:upload_url]
      return upload_url.to_s
    end
  end

  class DocumentDownloadUrl
    def initialize(options)
      @options = options
    end

    def url(node_id)
      download_url = @options[:download_url].concat("/").concat(node_id).strip
      return download_url.to_s
    end
  end



  class AlfUnknownException
    attr_reader :message,:status
    def initialize(msg)
      @message = msg
      @status = "Failure"
    end
  end

  class AlfSucess
    attr_reader :node,:filename,:message,:status,:uploaddirectory
    def initialize(node,filename,desc)
       @node = node.split("/").last
       @filename = filename
       @message = desc
       @status = "Success"
       @uploaddirectory = ''
    end
  end

  class AlfError
    attr_reader :message,:status
    def initialize(msg)
      @message = msg
      @status = "Failure"
    end
  end

  class AlfSucessStream
    attr_reader :data_stream,:message,:status
    def initialize(data_stream,desc=nil)
       @data_stream  = data_stream
       @message = desc
       @status = "Success"
    end

  end
end
