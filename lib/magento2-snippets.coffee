Magento2SnippetsView = require './magento2-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = Magento2Snippets =
  magento2SnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @magento2SnippetsView = new Magento2SnippetsView(state.magento2SnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @magento2SnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'magento2-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @magento2SnippetsView.destroy()

  serialize: ->
    magento2SnippetsViewState: @magento2SnippetsView.serialize()

  toggle: ->
    console.log 'Magento2Snippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
