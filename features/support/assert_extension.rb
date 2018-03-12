class AssertExtension

    def assert_displayed(el)
      assert_true(el.displayed?, 'O elemento deve ser exibido!')
    end
  
    def assert_not_displayed(el)
      assert_false(el.displayed?, 'O elemento não deve ser exibido!')
    end
  
    def assert_exists(id)
      assert_true(element_exists_by_id?(id), 'O elemento deve existir!')
    end
  
    def assert_not_exists(id)
      if $ENV == IOS
        # existe mas não está exibido
        assert_true(element_exists_by_id?(id), 'O elemento deve existir!')
        assert_not_displayed($driver.id(id))
      else
        assert_false(element_exists_by_id?(id), 'O elemento não deve existir!')
      end
    end
  
    def assert_cell_text(cell, expected_text)
      if $ENV == IOS
        text = 'UIAStaticText'
      else
        text = 'android.widget.TextView'
      end
  
      cell_text = cell.find_element(:class, text).text
  
      assert_displayed(cell)
      assert_equal(expected_text, cell_text)
    end
  
    def one_element_exists_and_displayed(el)
      assert(el.size == 1, '1 elemento deve existir')
      assert(el[0].displayed?, 'Primeiro elemento deve ser exibido!')
    end
  
    def more_than_one_element_are_existing_and_displayed(list)
      assert_operator(list.size, :>, 1, 'Mais de 1 elemento deve existir')
      assert(list[0].layer.displayed?, 'Primeiro elemento deve ser exibido!')
      assert(list[1].layer.displayed?, 'Segundo elemento deve ser exibido!')
    end
  
    def wait_maximum_10_seconds_for_an_element(id, timeout = 10)
      wait = Selenium::WebDriver::Wait.new :timeout => timeout
      wait.until { $driver.find_element(:id, id).displayed? }
    end
  
    def element_exists_by_id?(my_id)
      if $driver.find_elements(:id, my_id).size == 0
        false
      else
        true
      end
    end
  end