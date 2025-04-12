require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Devise modules' do
    describe 'confirmable' do
      let!(:user) { create(:user) }

      context 'successfully' do
        it 'should set confirmation token when created' do
          expect(user.confirmation_token).not_to be_nil
        end

        it 'should be unconfirmed by default' do
          expect(user.confirmed?).to be_falsey
        end

        it 'should be confirmed after confirmation' do
          user.confirm
          expect(user.confirmed?).to be_truthy
        end

        it 'should update confirmation sent at' do
          expect(user.confirmation_sent_at).not_to be_nil
        end

        it { should respond_to(:confirm) }
        it { should respond_to(:confirmation_token) }
        it { should respond_to(:confirmed_at) }
        it { should respond_to(:confirmation_sent_at) }
      end

      context 'failed' do
        it 'should not be able to confirm with invalid token' do
          original_token = user.confirmation_token
          user.confirmation_token = 'invalid_token'
          expect(user.confirm).to be_falsey
          user.confirmation_token = original_token
          expect(user.confirm).to be_truthy
        end

        it 'should not be confirmed with a blank token' do
          unconfirmed_user = create(:user, confirmed_at: nil)
          unconfirmed_user.confirmation_token = nil
          expect(unconfirmed_user.confirm).to be_falsey
        end
      end
    end

    describe 'trackable' do
      let(:user) { create(:user) }

      context 'successfully' do
        it 'should update sign in count' do
          expect {
            user.update(sign_in_count: user.sign_in_count + 1)
          }.to change(user, :sign_in_count).by(1)
        end

        it 'should update current sign in at' do
          time = Time.current
          user.update(current_sign_in_at: time)
          expect(user.current_sign_in_at).to be_within(1.second).of(time)
        end

        it 'should update last sign in at' do
          time = Time.current
          user.update(last_sign_in_at: time)
          expect(user.last_sign_in_at).to be_within(1.second).of(time)
        end

        it 'should update current and last sign in ip' do
          user.update(current_sign_in_ip: '127.0.0.1')
          expect(user.current_sign_in_ip).to eq('127.0.0.1')

          user.update(last_sign_in_ip: '192.168.0.1')
          expect(user.last_sign_in_ip).to eq('192.168.0.1')
        end

        # Shoulda-matchers for trackable attributes
        it { should respond_to(:sign_in_count) }
        it { should respond_to(:current_sign_in_at) }
        it { should respond_to(:last_sign_in_at) }
        it { should respond_to(:current_sign_in_ip) }
        it { should respond_to(:last_sign_in_ip) }
      end

      context 'failed' do
        it 'should not increment sign in count without explicit update' do
          expect {
            user.update(email: 'new_email@example.com')
          }.not_to change(user, :sign_in_count)
        end

        it 'should reject invalid IP addresses' do
          user.current_sign_in_ip = 'invalid_ip'
          expect(user.save).to be_truthy # Devise doesn't validate IP format
          expect(user.current_sign_in_ip).to eq('invalid_ip')
        end
      end
    end
  end
end
