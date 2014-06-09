require 'ruby-progressbar'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def unzip_package (zip_file_path, destination_folder)
	  Zip::File.open(zip_file_path.to_s) do |zip_file|
	    zip_file.each do |entry|
	      entry.extract(destination_folder + '/' + entry.name)
	    end
	  end
	end

	def zip_package (origin_folder, destination_file_path)
		Zip::File.open(destination_file_path, Zip::File::CREATE) do |zipfile|
		    Dir[File.join(origin_folder, '**', '**')].each do |file|
		      zipfile.add(file.sub(origin_folder, ''), file)
		    end
		end
	end
    
end
