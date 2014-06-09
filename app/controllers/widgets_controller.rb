class WidgetsController < ApplicationController
  before_action :set_widget, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /widgets
  # GET /widgets.json
  def index
    @widgets = Widget.all
  end

  # GET /widgets/1
  # GET /widgets/1.json
  def show
  end

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  # GET /widgets/1/edit
  def edit
  end

  # POST /widgets
  # POST /widgets.json
  def create
    @widget = Widget.new(widget_params)

    respond_to do |format|
      if @widget.save

        save_file

        format.html { redirect_to @widget, notice: 'Widget was successfully created.' }
        format.json { render :show, status: :created, location: @widget }
      else
        format.html { render :new }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /widgets/1
  # PATCH/PUT /widgets/1.json
  def update
    respond_to do |format|
      if @widget.update(widget_params)

        save_file

        format.html { redirect_to @widget, notice: 'Widget was successfully updated.' }
        format.json { render :show, status: :ok, location: @widget }
      else
        format.html { render :edit }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /widgets/1
  # DELETE /widgets/1.json
  def destroy
    @widget.destroy

    FileUtils.rm_r(generate_widget_files_path, {force: true})

    respond_to do |format|
      format.html { redirect_to widgets_url, notice: 'Widget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def widget_params
      params.require(:widget).permit(:title, :full_path, :book_id)
    end

    def save_file
      uploaded_io = params[:widget][:zip]
        
      full_path = FileUtils.mkdir_p (generate_widget_files_path)
      file_name = 'widget.zip'

      file_path = Rails.root.join(full_path[0], file_name)
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end

      @widget.update({full_path: file_path.to_s})

      unzip_package(file_path, full_path)

      FileUtils.rm(file_path, {force: true})
    end

    def generate_widget_files_path
      Rails.root.join('public', 'widgets', @widget.id.to_s )
    end
end