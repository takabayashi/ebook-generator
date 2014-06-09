require 'zip'
Zip.setup do |config|
	config.on_exists_proc = true
	config.continue_on_exists_proc = true
	config.unicode_names = true
	config.default_compression = Zlib::NO_COMPRESSION
end