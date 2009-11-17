# encoding: utf-8

module I18n
  module Helpers
    # Implements classical Gettext style accessors. To use this include the
    # module to the global namespace or wherever you want to use it.
    #
    #   include I18n::Helpers::Gettext
    module Gettext
      def gettext(msgid, options = {})
        I18n.t(msgid, { :default => msgid, :separator => '|' }.merge(options))
      end
      alias _ gettext

      def sgettext(msgid, separator = '|')
        scope, msgid = I18n::Gettext.extract_scope(msgid, separator)
        I18n.t(msgid, :scope => scope, :default => msgid)
      end
      alias s_ sgettext

      def pgettext(msgctxt, msgid)
        separator = I18n::Gettext::CONTEXT_SEPARATOR
        sgettext([msgctxt, msgid].join(separator), separator)
      end
      alias p_ pgettext

      def ngettext(msgid, msgid_plural, n = 1)
        nsgettext(msgid, msgid_plural, n, nil)
      end
      alias n_ ngettext

      def nsgettext(msgid, msgid_plural, n = 1, separator = nil)
        scope, msgid = I18n::Gettext.extract_scope(msgid, separator)
        default = { :one => msgid, :other => msgid_plural }
        msgid = [msgid, I18n::Gettext::PLURAL_SEPARATOR, msgid_plural].join
        I18n.t(msgid, :default => default, :count => n, :scope => scope)
      end
      alias ns_ nsgettext

      def npgettext(msgctxt, msgid, msgid_plural, n = 1)
        separator = I18n::Gettext::CONTEXT_SEPARATOR
        nsgettext([msgctxt, msgid].join(separator), msgid_plural, n, separator)
      end
      alias np_ npgettext
    end
  end
end
