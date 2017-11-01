class NotesController < ApplicationController
  before_action :current_destination

  def new
    @note = Note.new
  end

  def create
    @note = @destination.notes.build(note_params)
    @note.user_id = current_user.id
    if @note.save
      render 'notes/show', :layout => false
    else
      render 'destinations/show'
    end
  end

  def show

  end

  def destroy
    @note = @destination.notes.find(params[:id])
    @note.destroy
    render json: @destination.notes
  end

  private

  def current_destination
    @destination = Destination.find_by(id: params[:id])
  end

  def note_params
    params.require(:note).permit(:destination_id, :content)
  end

end
