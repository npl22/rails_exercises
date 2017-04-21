class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]
    if @note.save
    else
      flash[:errors] = @note.errors.full_messages
    end

    redirect_to track_url(params[:track_id])
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.user == current_user
      @note.destroy
      redirect_to track_url(@note.track)
    else
      render status: :forbidden, text: "hey you can't do that"
    end
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :track_id, :text)
  end
end
