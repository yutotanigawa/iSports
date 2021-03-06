class RoomsController < ApplicationController
    before_action :authenticate_user!

    def create
        @room = Room.create
        @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
        @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
        redirect_to "/rooms/#{@room.id}"
    end

    def show
        @room = Room.find(params[:id])
        if Entry.where(user_id: current_user.id,room_id: @room.id).present?
                        # メッセージの受信者のidをEntryから自分以外で検索し代入。未読アテンション表示のための準備として
                        @receive_user = Entry.where(room_id: params[:id]).where('user_id != ?', current_user.id).first
                        if Message.where(room_id: params[:id]).where(receive_user_id: current_user.id).present?
                            @room_message = Message.where(room_id: params[:id]).where(receive_user_id: current_user.id)
                            @room_message.update(receive_user_id_checked_message: current_user.id)
                        end
        @messages = @room.messages
        @message = Message.new
        @entries = @room.entries
        else
        redirect_back(fallback_location: root_path)
        end
    end

    def index
        @rooms = Room.all
        @user = current_user
        @currentEntries = @current_user.entries
        myRoomIds = []
        @currentEntries.each do |entry|
            myRoomIds << entry.room.id
        end
        @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?',@user.id)
    end
end
