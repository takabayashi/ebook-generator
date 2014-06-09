class BookTemplatesController < ApplicationController
  before_action :set_book_template, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /book_templates
  # GET /book_templates.json
  def index
    @book_templates = BookTemplate.all
  end

  # GET /book_templates/1
  # GET /book_templates/1.json
  def show
  end

  # GET /book_templates/new
  def new
    @book_template = BookTemplate.new
  end

  # GET /book_templates/1/edit
  def edit
  end

  # POST /book_templates
  # POST /book_templates.json
  def create
    @book_template = BookTemplate.new(book_template_params)
    
    respond_to do |format|
      if @book_template.save

        save_file
        
        format.html { redirect_to @book_template, notice: 'Book template was successfully created.' }
        format.json { render :show, status: :created, location: @book_template }
      else
        format.html { render :new }
        format.json { render json: @book_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_templates/1
  # PATCH/PUT /book_templates/1.json
  def update
    respond_to do |format|
      if @book_template.update(book_template_params)

        save_file

        format.html { redirect_to @book_template, notice: 'Book template was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_template }
      else
        format.html { render :edit }
        format.json { render json: @book_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_templates/1
  # DELETE /book_templates/1.json
  def destroy
    @book_template.destroy

    FileUtils.rm_r(generate_book_template_files_path, {force: true})

    respond_to do |format|
      format.html { redirect_to book_templates_url, notice: 'Book template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_template
      @book_template = BookTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_template_params
      params.require(:book_template).permit(:title, :book_qt)
    end

    def save_file
      uploaded_io = params[:book_template][:zip]
        
      full_path = FileUtils.mkdir_p (generate_book_template_files_path)
      file_name = 'template.zip'

      file_path = Rails.root.join(full_path[0], file_name)
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end

      @book_template.update({file_path: file_path.to_s})
    end

    def generate_book_template_files_path
      Rails.root.join('public', 'templates', @book_template.id.to_s )
    end
end
