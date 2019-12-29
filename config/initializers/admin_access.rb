class CanAccessFlipperUI
  def self.matches?(request)
    current_admin = request.env['warden'].user
    current_admin.present?
  end
end