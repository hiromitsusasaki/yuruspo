class LineBot::ForUser::CancellFlagWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 0

  def perform(flag_name, user_id)
    cancelledUser = User.find_by(line_user_id: user_id)
    if eval("cancelledUser.#{flag_name} == true")
      eval("cancelledUser.update(#{flag_name}: false)")
      push_notification flag_name, user_id
    end
  end

  private

  def push_notification flag_name, user_id
    case flag_name
    when "flag_is_about_to_asking"
      messages = cancell_is_about_to_asking_message
    end
    LineBot::ForUser::PushWorker.perform_async(user_id, messages)
  end


  def cancell_is_about_to_asking_message
    messages = [
      {
        type: 'text',
        text: "お問い合わせをして30分が経過したのでお問い合わせをキャンセルしたよ\nまたお問い合わせがしたくなった場合は「メニュー→ヘルプ→お問い合わせ」からお問い合わせしてね！"
      }
    ]
  end

end
