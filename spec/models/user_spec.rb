require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効なfactoryを持つこと' do
    expect(FactoryBot.build(:user)).to be_valid
  end
end
