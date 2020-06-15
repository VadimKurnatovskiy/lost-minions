# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PetQuery, type: :query do
  describe '#all' do
    subject(:all) { described_class.new(Pet.all, params).all }

    context 'when there is no param' do
      subject(:all) { described_class.new.all }

      let!(:pets) { create_list(:pet, 2) }

      it 'returns all pets' do
        expect(all).to match_array(pets)
      end
    end

    context 'when alling by situation' do
      let!(:lost_pet) { create(:pet, situation: :lost) }
      let(:params) do
        {
          situation: :lost
        }
      end

      it 'returns pets with specified situation' do
        create(:pet, situation: :found)

        expect(all).to eq([lost_pet])
      end
    end

    context 'when alling by breed' do
      let!(:beagle) { create(:breed, name: 'Beagle') }
      let!(:dachshund) { create(:breed, name: 'Dachshund') }
      let!(:pet) { create(:pet, breed: dachshund) }
      let(:params) do
        {
          breed: dachshund.id
        }
      end

      it 'returns pets with specified breed' do
        create(:pet, breed: beagle)

        expect(all).to match_array([pet])
      end
    end

    context 'when alling by gender' do
      let!(:pet) { create(:pet, gender: :male) }
      let(:params) do
        {
          gender: 'male'
        }
      end

      it 'returns pets with specified gender' do
        create(:pet, gender: :female)

        expect(all).to match_array([pet])
      end
    end

    context 'when alling by address' do
      let!(:pet) { create(:pet, address: 'Russia') }
      let(:params) do
        {
          address: 'Russia'
        }
      end

      it 'returns pets with specified address' do
        create(:pet, address: 'Kazan')

        expect(all).to match_array([pet])
      end
    end

    context 'when alling by area' do
      let!(:pet1) { create(:pet, address: 'Казань Пушкина 32') }
      let!(:pet2) { create(:pet, address: 'Казань Пушкина 46') }
      let(:params) do
        {
          near: {
            radius: 100,
            latitude: '55.7937213',
            longitude: '49.125303'
          }
        }
      end

      it 'returns pets with specified address (closest to farthest)' do
        create(:pet, address: 'Moscow')

        expect(all).to eq([pet2, pet1])
      end
    end
  end
end
