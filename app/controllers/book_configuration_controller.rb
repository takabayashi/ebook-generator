require 'RMagick'

class BookConfigurationController < ApplicationController
	include Magick
	layout false
	before_action :authenticate_user!

	def convert
		@book = Book.find(params[:id])
		
		dir_path = File.dirname(@book.file_path)
		
		full_path = File.join(dir_path, "images")
		if File.exists? full_path
			puts "Apagando pasta #{full_path} ..."
			FileUtils.rm_r(full_path, {force: true})
		end

		FileUtils.mkdir_p (full_path)

		puts "Convertendo arquivo pdf em images ..."
		
		progressbar = ProgressBar.create(:title => "Arquivos convertidos", :starting_at => 1, :total => @book.total_pages.to_i + 1)

		image = Magick::ImageList.new(@book.file_path) do
		  self.format = 'PDF'
		  self.quality = 100
		  self.density = 150
		end.each_with_index do |img, i|
			#img.resize_to_fit!(1496, 2008)
			img.write(File.join(full_path, "Page-#{i}.jpg"))

			progressbar.increment
		end

		@book.update({images_path: full_path})

		puts "Processo finalizado!"

		redirect_to "/configurate/#{@book.id}"
	end

	def configurate
		@book = Book.find(params[:id])
	end

	def build
		@book = Book.find(params[:id])
		temp_path = File.join(File.dirname(@book.file_path), 'temp')

		#copia o template correto
		template_archive = BookTemplate.find_by({title: @book.book_template}).file_path
		template_path = File.dirname(template_archive)
		unzip_package(template_archive, temp_path)

		#copia as imagens para o caminho correto
		images_path = File.join(File.dirname(@book.file_path), 'images', '*')
		FileUtils.cp_r(Dir[images_path], File.join(temp_path, 'livros', '1'))

		#copia os scripts para o caminho correto
		scripts_path = File.join(File.dirname(@book.file_path), 'scripts', '*')
		FileUtils.cp_r(Dir[scripts_path], File.join(temp_path, 'js'))

		#gera o arquivo zipado
		generated_zip = File.join(File.dirname(@book.file_path), 'temp.zip')
		zip_package(temp_path+"/", generated_zip)

		#apaga a pasta temporaria
		FileUtils.rm_r(temp_path, {force: true})

		#oferece para download o pacote criado
		if send_data(generated_zip, :filename => "#{@book.title}.zip", :type => "application/zip")
			FileUtils.rm(generated_zip, {force: true})
		end
	end
end
