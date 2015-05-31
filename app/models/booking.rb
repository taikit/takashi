class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  belongs_to :day

  def save_with_pay(token)
    if valid?
      begin
        webpay = WebPay.new(ENV['WEBPAY_SECRET'])
        charge = webpay.charge.create(
            :amount => plan.amount,
            :currency => "jpy",
            :card => token
        )
      rescue WebPay::ErrorResponse::CardError => e
        # カードが拒否された場合
        errors.add :base, "Your card has problem."
        logger.error "WebPay error while charging: #{e.message}"
        return false
      rescue WebPay::ErrorResponse::InvalidRequestError => e
        # リクエストで指定したパラメータが不正な場合
        errors.add :base, "Charge problem was occurd. Parameter error"
        logger.error "WebPay error while charging: #{e.message}"
        return false
      rescue WebPay::ErrorResponse::AuthenticationError => e
        # 認証に失敗した場合
        errors.add :base, "Charge problem was occurd. Auth error."
        logger.error "WebPay error while charging: #{e.message}"
        return false
      rescue WebPay::ErrorResponse::ApiError => e
        # APIへの接続エラーが起きた場合
        errors.add :base, "Charge problem was occurd. API error"
        logger.error "WebPay error while charging: #{e.message}"
        return false
      rescue WebPay::InvalidRequestError => e
        # WebPayのサーバでエラーが起きた場合
        errors.add :base, "Charge problem was occurd. Parameter error"
        logger.error "WebPay error while charging: #{e.message}"
        return false
      rescue WebPay::ApiConnectionError => e
        # WebPayのサーバでエラーが起きた場合
        errors.add :base, "Charge problem was occurd. Parameter error"
        logger.error "WebPay error while charging: #{e.message}"
        return false
      rescue => e
        # WebPayとは関係ない例外の場合
        errors.add :base, "Charge problem was occurd. Inter error"
        logger.error "WebPay error while charging: #{e.message}"
        return false
      end
    else
      return false
    end
    self.charge_id = charge.id
    self.card_fingerprint = charge.card.fingerprint
    save
  end
end
