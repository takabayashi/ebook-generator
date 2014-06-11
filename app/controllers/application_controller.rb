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

	def s3_upload (object_key, file_path)
		puts S3_CONFIG
		buket_name = S3_CONFIG["buket_name"]

		s3 = AWS::S3.new(
			:access_key_id => S3_CONFIG["access_key_id"],
  			:secret_access_key => S3_CONFIG["secret_access_key"]
  			)

		bucket = s3.buckets[buket_name]
		bucket = s3.buckets.create(buket_name) unless bucket.exists?

		obj = bucket.objects.create(object_key, Pathname.new(file_path))

		obj.url_for(:get, { :expires => 20.minutes.from_now, :secure => true }).to_s
	end   
end
