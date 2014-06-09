require 'pdf/reader'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /books
  # GET /books.json
  def index
    @books = Book.order("title").page(params[:page])
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        
        save_file

        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)

        save_file

        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      
      FileUtils.rm_r(generate_book_files_path, {force: true})

      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :book_template)
    end

    def save_file
      principal_file = params[:book][:principal]
        
      full_path = FileUtils.mkdir_p (generate_book_files_path)
      file_name = 'book.pdf'

      file_path = Rails.root.join(full_path[0], file_name)
      File.open(file_path, 'wb') do |file|
        file.write(principal_file.read)
      end

      attachment_file = params[:book][:attachment]

      if attachment_file
        attachment_path = Rails.root.join(full_path[0], 'attachment.pdf')
        File.open(attachment_path, 'wb') do |file|
          file.write(attachment_file.read)
        end
      end

      pdf_reader = PDF::Reader.new(file_path)

      @book.update({file_path: file_path.to_s, 
                    total_pages: pdf_reader.page_count,
                    metadata: pdf_reader.metadata,
                    pdf_version: pdf_reader.pdf_version,
                    attachment_path: attachment_path.to_s})
    end

    def generate_book_files_path
      Rails.root.join('public', 'books', @book.id.to_s )
    end
end
