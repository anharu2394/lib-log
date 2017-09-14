Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    Rails.application.secrets.google_client_id,
    Rails.application.secrets.google_client_secret,
    {
# ログイン後にGoogle Calendarのデータを取得したいので、scopeに
# https://www.googleapis.com/auth/calendarを記述しています。
# また、promptとaccess_typeを以下の設定にするとrefresh_tokenが得られる
# （その他の組み合わせは試していません）。
      scope: "https://www.googleapis.com/auth/userinfo.email,
              https://www.googleapis.com/auth/userinfo.profile,
              https://www.googleapis.com/auth/calendar",
      prompt: "select_account",
      access_type: "offline"
    }
end
