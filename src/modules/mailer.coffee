mandrill = require 'mandrill-api'
Core = require 'sublime-core'

# Wraps the Mandrill API
class Mailer extends Core.CoreObject
  # Construct a new Mailer
  #
  # @param [String] clientId The client ID provided by Mandrill
  constructor: (clientId) ->
    super()
    @clientId = clientId
    @api = new mandrill.Mandrill @clientId

  # Send an email
  #
  # @param [String] to The recipient email address
  # @param [String] from The sending email address
  # @param [String] subject The subject
  # @param [String] body The email content
  # @param [Boolean] important The priority of the email
  # @param [Array] attachments The attachments of the email
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


  # Send an email with a predefined template
  #
  # @param [String] template The template name
  # @param [String] to The recipient email address
  # @param [String] from The sending email address
  # @param [String] subject The subject
  # @param [Boolean] important The priority of the email
  # @param [Array] attachments The attachments of the email
  # @param [Object] content The KVP containing the message substitutes
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
