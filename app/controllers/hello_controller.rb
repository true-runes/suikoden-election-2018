class HelloController < ApplicationController
  def index
    rows = [
      [
        'Alvin',
        'Eclair',
        '$0.87',
      ],
      [
        'Alan',
        'Jellybean',
        '$3.76',
      ],
      [
        'Jonathan',
        'Lollipop',
        '$7.00',
      ],
      [
        'Shannon',
        'Eclair',
        '$9.99',
      ],
    ]

    @return_value = rows
  end
end
