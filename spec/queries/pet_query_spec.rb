# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PetQuery, type: :query do
  describe '#filter' do
    subject(:filter) { described_class.new.filter(params) }

    context 'when there is no param' do
      subject(:filter) { described_class.new.filter }

      let!(:pets) { create_list(:pet, 2) }

      it 'returns all pets' do
        expect(filter).to match_array(pets)
      end
    end

    context 'when filtering by situation' do
      let!(:lost_pet) { create(:pet, situation: :lost) }
      let(:params) do
        {
          situation: :lost
        }
      end

      it 'returns pets with specified situation' do
        create(:pet, situation: :found)

        expect(filter).to match_array([lost_pet])
      end
    end

    context 'when filtering by breed' do
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

        expect(filter).to match_array([pet])
      end
    end

    context 'when filtering by gender' do
      let!(:pet) { create(:pet, gender: :male) }
      let(:params) do
        {
          gender: 'male'
        }
      end

      it 'returns pets with specified gender' do
        create(:pet, gender: :female)

        expect(filter).to match_array([pet])
      end
    end

    context 'when filtering by address' do
      let!(:pet) { create(:pet, address: 'Russia') }
      let(:params) do
        {
          address: 'Russia'
        }
      end

      it 'returns pets with specified address' do
        create(:pet, address: 'Kazan')

        expect(filter).to match_array([pet])
      end
    end

    context 'when filtering by area' do
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

        expect(filter).to eq([pet2, pet1])
      end
    end
  end
end
