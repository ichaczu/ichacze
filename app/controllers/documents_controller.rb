require 'rest-client'
require 'open-uri'

class DocumentsController < ApplicationController
  def download
    resource = RestClient.get('http://127.0.0.1:8000/generate', { params: { id: params[:id], format: params[:file_format], pesel: params[:pesel] } })
    json = JSON.parse(resource)
    data = open(json["s3_url"]).read
    send_data data, filename: json["file_name"]
  end
end
