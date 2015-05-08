mandrill = require 'mandrill-api'
Core = require 'sublime-core'

class Mailer extends Core.CoreObject
  constructor: (clientId) ->
    super()
    @clientId = clientId
    @api = new mandrill.Mandrill @clientId

  send: (to, from, subject, body, important, attachments) ->
    @api.messages.send
      message: {
        html: body,
        subject: subject,
        'from_email': from,
        to: [{
          email: to
        }],
        important: important || false,
        attachments: attachments || []
      }
      , (res) =>
        @emit 'sent', res
      , (error) =>
        @emit 'sent', error: error

  sendTemplate: (template, to, from, subject, important, attachments, content) ->
    @api.messages.sendTemplate
      'template_name': template,
      'template_content': content || [],
      message: {
        subject: subject,
        'from_email': from,
        to: [{
          email: to
        }],
        important: important || false,
        attachments: attachments || [],
        'inline_css': true
      }
    , (res) =>
      @emit 'sent', res
    , (error) =>
      @emit 'sent', error: error

module.exports = Mailer
