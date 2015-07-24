json.array!(@myfiles) do |myfile|
  json.extract! myfile, :id, :file_name, :file_path, :file_md5
  json.url myfile_url(myfile, format: :json)
end
