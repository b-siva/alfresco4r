$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'alfresco4r'
require 'alfresco4r/document_download'
require 'alfresco4r/document_upload'


class TestAlfresco4r < Test::Unit::TestCase

  

  def test_download_empty_params_class
     options = {}
     download_obj = Alfresco4r::DocumentDownload.new(options)
     assert_kind_of(Alfresco4r::AlfError, download_obj.response)
  end

  def test_download_empty_params_message
     options = {}
     download_obj = Alfresco4r::DocumentDownload.new(options)
     assert_equal("Empty Parameter", download_obj.response.message)
  end

  def test_download_empty_params_status
     options = {}
     download_obj = Alfresco4r::DocumentDownload.new(options)
     assert_equal("Failure", download_obj.response.status)
  end

  def test_download_missing_params_class
     options = {:full_file_name => 'test.pdf'}
     download_obj = Alfresco4r::DocumentDownload.new(options)
     assert_kind_of(Alfresco4r::AlfError, download_obj.response)
  end

  def test_download_missing_params_message
     options = {:full_file_name => 'test.pdf'}
     download_obj = Alfresco4r::DocumentDownload.new(options)
     assert_equal("Failure", download_obj.response.status)
  end

  def test_download_missing_params_message
     options = {:full_file_name => 'test.pdf'}
     download_obj = Alfresco4r::DocumentDownload.new(options)
     missing_params = Alfresco4r::DocumentDownload::EXPECTED_PARAMS - options.keys
     msg = "Expected paramerter #{missing_params} are missing. Expected parameters are :download_url,:node"
     assert_equal(msg, download_obj.response.message)
  end

  def test_alfunknownexception_class
     obj = Alfresco4r::AlfUnknownException.new("test message")
     assert_kind_of(Alfresco4r::AlfUnknownException, obj)
  end

  def test_alfunknownexception_message
     obj = Alfresco4r::AlfUnknownException.new("test message")
     assert_equal("test message", obj.message)
  end

  def test_alfunknownexception_status
     obj = Alfresco4r::AlfUnknownException.new("test message")
     assert_equal("Failure", obj.status)
  end

  def test_alferror_class
     obj = Alfresco4r::AlfError.new("test message")
     assert_kind_of(Alfresco4r::AlfError, obj)
  end

  def test_alferror_message
     obj = Alfresco4r::AlfError.new("test message")
     assert_equal("test message", obj.message)
  end

  def test_alferror_status
     obj = Alfresco4r::AlfError.new("test message")
     assert_equal("Failure", obj.status)
  end

  def test_alfsucess_class
     obj = Alfresco4r::AlfSucess.new("node/aj98201233","test.pdf","test description")
     assert_kind_of(Alfresco4r::AlfSucess, obj)
  end

  def test_alfsucess_message
     obj = Alfresco4r::AlfSucess.new("node/aj98201233","test.pdf","test description")
     assert_equal("test description", obj.message)
  end

  def test_alfsucess_status
     obj = Alfresco4r::AlfSucess.new("node/aj98201233","test.pdf","test description")
     assert_equal("Success", obj.status)
  end

  def test_alfsucess_node_split
     obj = Alfresco4r::AlfSucess.new("node/aj98201233","test.pdf","test description")
     assert_equal("aj98201233", obj.node)
  end

  def test_alfsucess_node_split_without_slash
     obj = Alfresco4r::AlfSucess.new("aj98201233","test.pdf","test description")
     assert_equal("aj98201233", obj.node)
  end

  def test_alfsucess_node_split_without_slash
     obj = Alfresco4r::AlfSucess.new("aj98201233","test.pdf","test description")
     assert_equal("test.pdf", obj.filename)
  end


  def test_alfsucessstream_class
     obj = Alfresco4r::AlfSucessStream.new("a8aksi920kdi029aj98201233","test message")
     assert_kind_of(Alfresco4r::AlfSucessStream, obj)
  end

  def test_alfsucessstream_message
     obj = Alfresco4r::AlfSucessStream.new("a8aksi920kdi029aj98201233","test message")
     assert_equal("test message", obj.message)
  end

  def test_alfsucessstream_message_nil
     obj = Alfresco4r::AlfSucessStream.new("a8aksi920kdi029aj98201233")
     assert_nil(obj.message)
  end

  def test_alfsucessstream_status
     obj = Alfresco4r::AlfSucessStream.new("a8aksi920kdi029aj98201233","test message")
     assert_equal("Success", obj.status)
  end

  def test_alfsucessstream_datastream
     obj = Alfresco4r::AlfSucessStream.new("a8aksi920kdi029aj98201233","test message")
     assert_equal("a8aksi920kdi029aj98201233", obj.data_stream)
  end

  def test_documentdownloadurl_class
     options = {:download_url => "http://youralfrescoservername:portnumber/alfresco/service/api/node/content/workspace/SpacesStore"}
     obj = Alfresco4r::DocumentDownloadUrl.new(options)
     assert_kind_of(Alfresco4r::DocumentDownloadUrl, obj)
  end

  def test_documentdownloadurl_url
     options = {:download_url => "http://youralfrescoservername:portnumber/alfresco/service/api/node/content/workspace/SpacesStore"}
     obj = Alfresco4r::DocumentDownloadUrl.new(options)
     test_url = "http://youralfrescoservername:portnumber/alfresco/service/api/node/content/workspace/SpacesStore".concat("/").concat("aj98201233").strip
     assert_equal(test_url, obj.url("aj98201233"))
  end

  def test_documentdownloadurl_url_empty_options
     options = {}
     obj = Alfresco4r::DocumentDownloadUrl.new(options)     
     assert_raise(NoMethodError){obj.url("aj98201233")}
  end


  def test_documentuploadurl_class
     options = {:upload_url => "http://youralfrescoservername:portnumber/alfresco/service/api/upload"}
     obj = Alfresco4r::DocumentUploadUrl.new(options)
     assert_kind_of(Alfresco4r::DocumentUploadUrl, obj)
  end

  def test_documentuploadurl_url
     options = {:upload_url => "http://youralfrescoservername:portnumber/alfresco/service/api/upload"}
     obj = Alfresco4r::DocumentUploadUrl.new(options)
     test_url = "http://youralfrescoservername:portnumber/alfresco/service/api/upload"
     assert_equal(test_url, obj.url)
  end

  def test_documentuploadurl_url_empty_options
     options = {}
     obj = Alfresco4r::DocumentUploadUrl.new(options)
     assert_equal("", obj.url)
  end

 

  def test_documentauth_class
     options = {:username => "username",:password => "password"}
     obj = Alfresco4r::DocumentAuth.new(options)
     assert_kind_of(Alfresco4r::DocumentAuth, obj)
  end

  def test_documentauth_with_username
     options = {:username => "username",:password => "password"}
     obj = Alfresco4r::DocumentAuth.new(options)
     assert_equal("username", obj.username)
  end



  def test_documentauth_no_username
     options = {:password => "password"}
     obj = Alfresco4r::DocumentAuth.new(options)
     assert_equal("", obj.username)
  end

  def test_documentauth_with_password
     options = {:username => "username",:password => "password"}
     obj = Alfresco4r::DocumentAuth.new(options)
     assert_equal("password", obj.password)
  end

  def test_documentauth_no_password
     options = {:username => "username"}
     obj = Alfresco4r::DocumentAuth.new(options)
     assert_equal("", obj.password)
  end



  def test_upload_empty_params_class
     options = {}
     upload_obj = Alfresco4r::DocumentUpload.new(options)
     assert_kind_of(Alfresco4r::AlfError, upload_obj.response)
  end

  def test_upload_empty_params_message
     options = {}
     upload_obj = Alfresco4r::DocumentUpload.new(options)
     assert_equal("Empty Parameter", upload_obj.response.message)
  end

  def test_upload_empty_params_status
     options = {}
     upload_obj = Alfresco4r::DocumentUpload.new(options)
     assert_equal("Failure", upload_obj.response.status)
  end

  def test_upload_missing_params_class
     options = {:siteid => 'siteid'}
     upload_obj = Alfresco4r::DocumentUpload.new(options)
     assert_kind_of(Alfresco4r::AlfError, upload_obj.response)
  end

  def test_upload_missing_params_message
     options = {:siteid => 'siteid'}
     upload_obj = Alfresco4r::DocumentUpload.new(options)
     assert_equal("Failure", upload_obj.response.status)
  end

  def test_upload_missing_params_message
     options = {:siteid => 'siteid'}
     upload_obj = Alfresco4r::DocumentUpload.new(options)
     missing_params = Alfresco4r::DocumentUpload::EXPECTED_PARAMS - options.keys
     msg = "Expected paramerter #{missing_params} are missing. Expected parameters are siteid,containerid,uploaddirectory,mime_type,full_file_name,filedata."
     assert_equal(msg, upload_obj.response.message)
  end
  



  
end
