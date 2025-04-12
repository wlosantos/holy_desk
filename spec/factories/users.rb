FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123123123' }
    password_confirmation { password }
    # adicionar os campos do confirmable
    confirmed_at { Time.current }
    confirmation_token { nil }
    confirmation_sent_at { nil }
    unconfirmed_email { nil } # Only if using reconfirmable
    # adicionar os campos do trackable
    sign_in_count { 0 }
    current_sign_in_at { nil }
    last_sign_in_at { nil }
    current_sign_in_ip { nil }
    last_sign_in_ip { nil }

    trait :unconfirmed do
      confirmed_at { nil }
      confirmation_token { SecureRandom.hex(10) }
      confirmation_sent_at { Time.current }
      unconfirmed_email { email }
    end

    # adicionar uma trait para a confirmação de email
    trait :confirmed do
      confirmed_at { Time.current }
      confirmation_token { SecureRandom.hex(10) }
      confirmation_sent_at { nil }
      unconfirmed_email { nil }
    end
    # adicionar uma trait para o trackable
    trait :trackable do
      sign_in_count { 1 }
      current_sign_in_at { Time.current }
      last_sign_in_at { Time.current - 1.day }
    end
  end
end
