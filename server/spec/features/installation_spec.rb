require 'rails_helper'

RSpec.feature "Installations", type: :feature do
  describe 'create an installation' do
    let!(:country) { FactoryBot.create(:country) }
    let!(:installer) { FactoryBot.create(:installer) }

    let(:phone) { '07 90 94 09 94' }

    before { visit '/' }

    context 'when form is untouched' do
      it 'displays a disabled submit button' do
        expect(page).to have_selector('button[disabled]')
      end
    end

    context 'when all required fields are set and valid' do
      it 'displays an enabled submit button' do
        filling_form_installation
        expect(page).not_to have_selector('button[disabled]')
      end

      it 'displays a success message when form submitted' do
        filling_form_installation
        click_button('Valider')
        within '#submit-message' do
          expect(page).to have_text("L'installation a bien été créée")
        end
      end
    end

    context 'when all required fields are set but phone invalid' do
      let(:phone) { '07 90 94 09 94 45 45 45 53 34' }

      it 'displays an error message when form submitted' do
        filling_form_installation
        click_button('Valider')
        within '#submit-message' do
          expect(page).to have_text('{"customer.phone":["is invalid"]}')
        end
      end
    end
  end

  describe 'individual field errors' do
    let!(:country) { FactoryBot.create(:country) }
    let!(:installer) { FactoryBot.create(:installer) }
    before { visit '/' }

    context 'when installer is empty' do
      it 'displays an error text' do
        select("#{installer.name} - #{installer.siren}", from: 'installer')
        select('', from: 'installer')
        expect(page).to have_text("L'installeur est obligatoire")
      end
    end

    context 'when customer name is empty' do
      it 'displays an error text' do
        fill_in('customer-name', with: 'Paul Desmond')
        fill_in('customer-name', with: '')
        expect(page).to have_text('Le nom du client est obligatoire')
      end
    end

    context 'when customer name is too long' do
      it 'displays an error text' do
        fill_in('customer-name', with: 'x' * 256)
        expect(page).to have_text('Le nom du client est limité à 255 caractères')
      end
    end

    context 'when email is empty' do
      it 'displays an error text' do
        fill_in('customer-email', with: 'pdesmond@orange.fr')
        fill_in('customer-email', with: '')
        expect(page).to have_text("L'email du client est obligatoire")
      end
    end

    context 'when email is too long' do
      it 'displays an error text' do
        fill_in('customer-email', with: 'x' * 256)
        expect(page).to have_text("L'email du client est limité à 255 caractères")
      end
    end

    context 'when email format is invalid' do
      it 'displays an error text' do
        fill_in('customer-email', with: 'pdesmond&orange.fr')
        expect(page).to have_text("Le format de l'email est invalide")
      end
    end

    context 'when address street is empty' do
      it 'displays an error text' do
        fill_in('address-street', with: '1, rue de la Charité')
        fill_in('address-street', with: '')
        expect(page).to have_text('Le nom de la rue est obligatoire')
      end
    end

    context 'when address street is too long' do
      it 'displays an error text' do
        fill_in('address-street', with: 'x' * 256)
        expect(page).to have_text('Le nom de la rue est limité à 255 caractères')
      end
    end

    context 'when address zipcode is empty' do
      it 'displays an error text' do
        fill_in('address-zipcode', with: '69001')
        fill_in('address-zipcode', with: '')
        expect(page).to have_text('Le code postal est obligatoire')
      end
    end

    context 'when address zipcode is too long' do
      it 'displays an error text' do
        fill_in('address-zipcode', with: 'x' * 21)
        expect(page).to have_text('Le code postal est limité à 20 caractères')
      end
    end

    context 'when address city is empty' do
      it 'displays an error text' do
        fill_in('address-city', with: 'Lyon')
        fill_in('address-city', with: '')
        expect(page).to have_text('Le nom de la ville est obligatoire')
      end
    end

    context 'when address city is too long' do
      it 'displays an error text' do
        fill_in('address-city', with: 'x' * 101)
        expect(page).to have_text('Le nom de la ville est limité à 100 caractères')
      end
    end

    context 'when address country is empty' do
      it 'displays an error text' do
        select('France', from: 'address-country')
        select('', from: 'address-country')
        expect(page).to have_text('Le pays est obligatoire')
      end
    end

    context 'when panels type is empty' do
      it 'displays an error text' do
        select('hybrid', from: 'panels-type')
        select('', from: 'panels-type')
        expect(page).to have_text('Le type de panneau est obligatoire')
      end
    end

    context 'when custom number is 0' do
      it 'displays an error text' do
        fill_in('panels-number', with: '2')
        fill_in('panels-number', with: '0')
        expect(page).to have_text('Le nombre ne peut être inférieur à 1')
      end
    end

    context 'when custom number is 51' do
      it 'displays an error text' do
        fill_in('panels-number', with: '2')
        fill_in('panels-number', with: '51')
        expect(page).to have_text('Le nombre ne peut être supérieur à 50')
      end
    end

    context 'when panels ids is empty' do
      it 'displays an error text' do
        fill_in('panels-number', with: '2')
        fill_in('panels-ids', with: '123456, 111222')
        fill_in('panels-ids', with: '')
        expect(page).to have_text('Vous devez renseigner les ID des panneaux installés')
      end
    end

    context 'when panels ids has an invalid id' do
      it 'displays an error text' do
        fill_in('panels-number', with: '2')
        fill_in('panels-ids', with: '123456, 1112x2')
        expect(page).to have_text("Le format d'un ID est invalide: 1112x2")
      end
    end

    context 'when panels ids does not match panels-number' do
      it 'displays an error text' do
        fill_in('panels-number', with: '3')
        fill_in('panels-ids', with: '123456, 111222')
        expect(page).to have_text('La valeur "Nombre de panneaux" ne correspond pas au nombre de références saisies')
      end
    end
  end
end

def filling_form_installation
  select("#{installer.name} - #{installer.siren}", from: 'installer')
  fill_in('customer-name', with: 'Paul Desmond')
  fill_in('customer-email', with: 'pdesmond@orange.fr')
  fill_in('customer-phone', with: phone)
  fill_in('address-street', with: '1, rue de la Charité')
  fill_in('address-zipcode', with: '69001')
  fill_in('address-city', with: 'Lyon')
  select('France', from: 'address-country')
  fill_in('panels-number', with: '2')
  select('hybrid', from: 'panels-type')
  fill_in('panels-ids', with: '123456, 111222')
end
