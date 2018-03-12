Dado('que eu esteja na tela de calculo') do
  custom.wait_for_text_to_exist('Simple Calculator Android')
end

Quando('eu fizer um calculo de adição') do
  base.add('100', '100')  
end

Entao('eu verifico o resultado da adição com sucesso') do
  @validate = calculator.result.text
  expect(@validate)
    .to include '200'
end