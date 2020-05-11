module ApplicationHelper
    def new_message_badge
        receive_user = Message.where(receive_user_id: current_user.id).count
        receive_user_checked_message = Message.where(receive_user_id_checked_message: current_user.id).count
        message_count = receive_user - receive_user_checked_message
        if 0 == message_count
        else
        # 未読メッセージがある際にdiv要素を吐き出させてuser/showに表示
        # 未読メッセージが無い際に未読バッジを表示させないため
        content_tag(:div,message_count, class: 'new-message-badge')
        end
    end
end
