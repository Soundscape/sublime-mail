lib = require '../'

describe 'Mailer test suite', ()  ->
  create = () ->
    new lib.Mailer('--APIKEY--')

  it 'should construct an instance', () ->
    instance = create()
    expect instance
      .not.toBeNull()

  it 'should send an email', () ->
    instance = create()
    expect instance
      .not.toBeNull()

    instance.send(
      'sfarrell.development@gmail.com'
      'sublime@mail.co.za'
      'Mailer unit test for simple send'
    )
