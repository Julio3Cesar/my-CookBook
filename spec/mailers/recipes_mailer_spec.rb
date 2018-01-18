require 'rails_helper'

RSpec.describe RecipesMailer do
  describe '#share' do
    it 'should send the correct email' do
      recipe = create(:recipe)

      mail = RecipesMailer.share('my_friend@email.com', 'blah', recipe.id)

      expect(mail.to).to include 'my_friend@email.com'
      expect(mail.subject).to eq 'Compartilharam uma receita com você'
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.body).to include 'blah'
      expect(mail.body).to include recipe_url(recipe)
    end
  end
end
