namespace :app do
	desc "Limpa todos os arquivos gerados de livros"
	task :clean_book_files do
		files_path = Rails.root.join('public', 'books')

		if File.exists? files_path
			FileUtils.rm_r(files_path, {force: true})
			puts "Pasta #{files_path} excluída com sucesso!"
		else
			puts "Não existe nada para ser excluído!"
		end
	end

	desc "Limpa todos os arquivos gerados de template"
	task :clean_book_template_files do
		files_path = Rails.root.join('public', 'templates')

		if File.exists? files_path
			FileUtils.rm_r(files_path, {force: true})
			puts "Pasta #{files_path} excluída com sucesso!"
		else
			puts "Não existe nada para ser excluído!"
		end
	end
end
