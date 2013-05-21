# Alfresco4r

This gem provides the capability to ruby to interact with Alfresco CMS. This gem is providing two methods upload
document to Alfresco and download/retrieve document from Alfresco.


## Installation

Add this line to your application's Gemfile:

    gem 'alfresco4r'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alfresco4r

## Usage

How to upload document to Alfresco

1) create an hash with below keys

    options = {                
                :upload_url=> 'http://replace_this_with_your_alfresco_server_name:port_number/alfresco/service/api/upload',
                :mime_type => 'text/plain',
                :full_file_name => 'test.txt',
                :filedata =>  file_data_in_binary_format,
                :siteid => 'siteid',
                :containerid => 'documentLibrary',
                :uploaddirectory => '/directoryname',
                :username=>"username",
                :password=>"password"
               }

    Explanation for each keys:

              upload_url => This is the REST based upload URL provided by Alfresco to upload document
              mime_type => Specify the MIME type for the file you are uploading
              full_file_name => Specify the file name you want to upload
              siteid => Specify the name of the site to upload the document
              containerid => Specify the space to upload
              uploaddirectory => Specify the directory name to upload
              filedata => This will have file data in binary format( eg: file_data_in_binary_format = File.open('test.txt','rb') {|f| f.read} )
              username => If the Alfresco expects the HTTP basic authentication, Specify the username here ( optional field )
              password => If the Alfresco expects the HTTP basic authentication, Specify the password here ( optional field )

2) create an object of Alfresco4r::DocumentUpload by passing the options created and check the response .

    upload_obj = Alfresco4r::DocumentUpload.new(options).response


3) Verify the status of the response object (upload_obj.status).

    Success status:
     if the status is "Success" your file is uploaded successfully to Alfresco.
     upload_obj.node will give the node ID corresponding to uploaded document. It will be something similar like '90aa0aa6-13f6-4b3f-936e-145ccc4aae53'
     upload_obj.filename will give the file name it uploaded to Alfresco.
     In case if Alfresco finds the similar file name exists already, it will rename file and provide the file name in return

    Failure status:
     if the status is "Failure" your file is not uploaded to Alfresco.
     upload_obj.message will give the description of error message.



How to download/retrieve  document from Alfresco

1) create an hash with below keys

    options = {                
                :download_url=> 'http://replace_this_with_your_alfresco_server_name:port_number/alfresco/service/api/node/content/workspace/SpacesStore',
                :node => '90aa0aa6-13f6-4b3f-936e-145ccc4aae53',
                :full_file_name => 'test.txt',
                :username=>"username",
                :password=>"password"
               }

   Explanation for each keys:

              download_url => This is the REST based download/retrieve URL provided by Alfresco to download/retrieve document  
              node =>  node is the unique ID of the document to download/retrieve     
              full_file_name => Specify the file name you want to download/retrieve ( optional field )             
              username => If the Alfresco expects the HTTP basic authentication, Specify the username here ( optional field )
              password => If the Alfresco expects the HTTP basic authentication, Specify the password here ( optional field )


2) create an object of Alfresco4r::DocumentDownload by passing the options created and check the response .

    download_obj = Alfresco4r::DocumentDownload.new(options).response



3) Verify the status of the response object (download_obj.status).

    Success status:
     if the status is "Success" you can proceed to call download_obj.data_stream to stream or write to file.
     
  
    Failure status:
     if the status is "Failure", download_obj.message will give the description of error message.


