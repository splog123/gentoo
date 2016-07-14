# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
USE_RUBY="ruby20"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Ohai profiles your system and emits JSON"
HOMEPAGE="http://wiki.opscode.com/display/chef/Ohai"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# specs have issues with multiple ruby versions
RESTRICT="test"

ruby_add_rdepend "
	dev-ruby/ipaddress
	>=dev-ruby/mime-types-1.16
	dev-ruby/mixlib-cli
	>=dev-ruby/mixlib-config-2.0
	dev-ruby/mixlib-log
	>=dev-ruby/mixlib-shellout-1.2
	>=dev-ruby/systemu-2.5.2
	dev-ruby/yajl-ruby"

all_ruby_install() {
	all_fakegem_install

	doman docs/man/man1/ohai.1
}
