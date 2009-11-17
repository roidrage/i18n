# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require 'i18n/backend/gettext'
require 'i18n/helpers/gettext'

include I18n::Helpers::Gettext

class I18nGettextApiTest < Test::Unit::TestCase
  def setup
    I18n.locale = :en
    I18n.backend.store_translations :de, {
      'Hi Gettext!' => 'Hallo Gettext!',
      'Sentence 1. Sentence 2.' => 'Satz 1. Satz 2.',
      "An apple#{I18n::Gettext::PLURAL_SEPARATOR}{{count}} apples" => { :one => 'Ein Apfel', :other => '{{count}} Äpfel' },
      :special => { 'An apple' => { :one => 'Ein spezieller Apfel', :other => '{{count}} spezielle Äpfel' } },
      :foo => { :bar => 'bar-de' }
    }
  end

  def test_gettext_uses_msg_as_default
    assert_equal 'Hi Gettext!', _('Hi Gettext!')
  end

  def test_gettext_uses_msg_as_key
    I18n.locale = :de
    assert_equal 'Hallo Gettext!', gettext('Hi Gettext!')
    assert_equal 'Hallo Gettext!', _('Hi Gettext!')
  end

  def test_gettext_uses_msg_containing_dots_as_default
    assert_equal 'Sentence 1. Sentence 2.', gettext('Sentence 1. Sentence 2.')
    assert_equal 'Sentence 1. Sentence 2.', _('Sentence 1. Sentence 2.')
  end

  def test_gettext_uses_msg_containing_dots_as_key
    I18n.locale = :de
    assert_equal 'Satz 1. Satz 2.', gettext('Sentence 1. Sentence 2.')
    assert_equal 'Satz 1. Satz 2.', _('Sentence 1. Sentence 2.')
  end

  def test_sgettext_defaults_to_the_last_token_of_a_scoped_msgid
    assert_equal 'bar', sgettext('foo|bar')
    assert_equal 'bar', s_('foo|bar')
  end

  def test_sgettext_looks_up_a_scoped_translation
    I18n.locale = :de
    assert_equal 'bar-de', sgettext('foo|bar')
    assert_equal 'bar-de', s_('foo|bar')
  end

  def test_pgettext_defaults_to_msgid
    assert_equal 'bar', pgettext('foo', 'bar')
    assert_equal 'bar', p_('foo', 'bar')
  end

  def test_pgettext_looks_up_a_scoped_translation
    I18n.locale = :de
    assert_equal 'bar-de', pgettext('foo', 'bar')
    assert_equal 'bar-de', p_('foo', 'bar')
  end

  def test_ngettext_looks_up_msg_id_as_default_singular
    assert_equal 'An apple', ngettext('An apple', '{{count}} apples', 1)
    assert_equal 'An apple', n_('An apple', '{{count}} apples', 1)
  end

  def test_ngettext_looks_up_msg_id_plural_as_default_plural
    assert_equal '2 apples', ngettext('An apple', '{{count}} apples', 2)
    assert_equal '2 apples', n_('An apple', '{{count}} apples', 2)
  end

  def test_ngettext_looks_up_msg_id_as_singular
    I18n.locale = :de
    assert_equal 'Ein Apfel', ngettext('An apple', '{{count}} apples', 1)
    assert_equal 'Ein Apfel', n_('An apple', '{{count}} apples', 1)
  end

  def test_ngettext_looks_up_msg_id_as_singular
    I18n.locale = :de
    assert_equal '2 Äpfel', ngettext('An apple', '{{count}} apples', 2)
    assert_equal '2 Äpfel', n_('An apple', '{{count}} apples', 2)
  end

  def test_nsgettext_looks_up_msg_id_as_default_singular
    assert_equal 'A special apple', nsgettext('special|A special apple', '{{count}} special apples', 1, '|')
    assert_equal 'A special apple', ns_('special|A special apple', '{{count}} special apples', 1, '|')
  end
end