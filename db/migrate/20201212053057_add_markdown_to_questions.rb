class AddMarkdownToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :markdown_content, :text
  end
end
