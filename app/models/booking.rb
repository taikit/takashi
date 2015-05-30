class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  belongs_to :day

  def save_with_pay
    if valid?
      begin
        webpay = WebPay.new(ENV["WEBPAY_PUBLIC"])
        charge = webpay.charge.create(
            :amount => amount,
            :currency => "usd",
            :card => webpay_card_token,
            :capture => false,
            :description => "email:#{user.email},contribution_price:#{contribution_price},project_id:#{project_id},gift_id:#{gift_id}"
        )
      rescue WebPay::ErrorResponse::CardError => e
        # カードが拒否された場合
        errors.add :base, "カードに問題があります"
        logger.error "WebPay error while charging: #{e.message}"
        self.confirming = ""
        return false
      rescue WebPay::ErrorResponse::InvalidRequestError => e
        # リクエストで指定したパラメータが不正な場合
        errors.add :base, "決済処理に問題が生じました パラメータエラー"
        logger.error "WebPay error while charging: #{e.message}"
        self.confirming = ""
        return false
      rescue WebPay::ErrorResponse::AuthenticationError => e
        # 認証に失敗した場合
        errors.add :base, "決済処理に問題が生じました 認証エラー"
        logger.error "WebPay error while charging: #{e.message}"
        self.confirming = ""
        return false
      rescue WebPay::ErrorResponse::ApiError => e
        # APIへの接続エラーが起きた場合
        errors.add :base, "決済処理に問題が生じました APIエラー"
        logger.error "WebPay error while charging: #{e.message}"
        self.confirming = ""
        return false
      rescue WebPay::InvalidRequestError => e
        # WebPayのサーバでエラーが起きた場合
        errors.add :base, "決済処理に問題が生じました パラメータエラー"
        logger.error "WebPay error while charging: #{e.message}"
        self.confirming = ""
        return false
      rescue WebPay::ApiConnectionError => e
        # WebPayのサーバでエラーが起きた場合
        errors.add :base, "決済処理に問題が生じました API接続エラー"
        logger.error "WebPay error while charging: #{e.message}"
        self.confirming = ""
        return false
      rescue => e
        # WebPayとは関係ない例外の場合
        errors.add :base, "決済処理に問題が生じました 内部エラー"
        logger.error "WebPay error while charging: #{e.message}"
        self.confirming = ""
        return false
      end
      self.charge_id = charge.id
      self.card_fingerprint = charge.card.fingerprint
      self.gift_price = gift.price
      save!
      OrderMailer.ordered(self).deliver
    end
  end
end
