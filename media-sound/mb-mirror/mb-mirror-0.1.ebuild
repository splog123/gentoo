# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://github.com/metabrainz/musicbrainz-server.git"

inherit user git-r3

DESCRIPTION="Meta package to install a MusicBrainz mirror server"
HOMEPAGE="https://github.com/metabrainz/musicbrainz-server"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/perl
	dev-db/postgresql:9.1[server]
	net-misc/memcached
	dev-db/redis
	net-libs/nodejs[npm]

	dev-libs/libxml2
	dev-libs/expat
	dev-libs/icu
	dev-perl/App-cpanminus

	dev-perl/set-scalar
	dev-perl/Algorithm-Diff
	dev-perl/Algorithm-Merge
	dev-perl/Authen-Passphrase
	dev-perl/Cache
	dev-perl/Cache-Memcached
	dev-perl/Cache-Memcached-Fast
	dev-perl/Captcha-reCAPTCHA
	dev-perl/Catalyst-Action-RenderView
	dev-perl/Catalyst-Authentication-Credential-HTTP
	dev-perl/Catalyst-Devel
	dev-perl/Catalyst-Plugin-Authentication
	dev-perl/Catalyst-Plugin-AutoRestart
	dev-perl/Catalyst-Plugin-Cache
	dev-perl/Catalyst-Plugin-ErrorCatcher
	dev-perl/Catalyst-Plugin-I18N
	dev-perl/Catalyst-Plugin-Session-State-Cookie
	dev-perl/Catalyst-Plugin-Session-Store-FastMmap
	dev-perl/Catalyst-Plugin-Session-Store-Memcached
	dev-perl/Catalyst-Plugin-StackTrace
	dev-perl/Catalyst-Runtime
	dev-perl/Catalyst-View-TT
	dev-perl/Class-Load
	dev-perl/Clone
	dev-perl/CSS-Minifier
	dev-perl/DBD-Pg
	dev-perl/DBIx-Connector
	dev-perl/Data-Compare
	dev-perl/Data-Dumper-Concise
	dev-perl/Data-OptList
	dev-perl/Data-Page
	dev-perl/Date-Calc
	dev-perl/DateTime-Format-ISO8601
	dev-perl/DateTime-Format-Natural
	dev-perl/DateTime-Format-Pg
	dev-perl/DateTime-TimeZone
	dev-perl/Digest-MD5-File
	dev-perl/Email-Address
	dev-perl/Email-MIME
	dev-perl/Email-Sender
	dev-perl/Email-Valid
	dev-perl/Encode-Detect
	dev-perl/Env-Path
	dev-perl/Exception-Class
	dev-perl/FCGI
	dev-perl/FCGI-ProcManager
	dev-perl/Hash-Merge
	dev-perl/HTML-FormHandler
	dev-perl/HTML-Selector-XPath
	dev-perl/HTML-TreeBuilder-XPath
	dev-perl/IO-All
	dev-perl/JSON
	dev-perl/JSON-XS
	dev-perl/List-AllUtils
	dev-perl/List-MoreUtils
	dev-perl/List-UtilsBy
	dev-perl/Locale-PO
	dev-perl/Log-Dispatch
	dev-perl/MRO-Compat
	dev-perl/Math-Random-Secure
	dev-perl/Method-Signatures-Simple
	dev-perl/Module-Pluggable
	dev-perl/Moose
	dev-perl/MooseX-Clone
	dev-perl/MooseX-Getopt
	dev-perl/MooseX-MethodAttributes
	dev-perl/MooseX-Role-Parameterized
	dev-perl/MooseX-Singleton
	dev-perl/MooseX-Types
	dev-perl/MooseX-Types-Structured
	dev-perl/MooseX-Types-URI
	dev-perl/Plack
	dev-perl/Readonly
	dev-perl/Redis
	dev-perl/String-CamelCase
	dev-perl/String-ShellQuote
	dev-perl/TAP-Parser-SourceHandler-pgTAP
	dev-perl/Template-Plugin-Class
	dev-perl/Template-Plugin-JavaScript
	dev-perl/Test-Aggregate
	dev-perl/Test-Differences
	dev-perl/Test-Fatal
	dev-perl/Test-JSON
	dev-perl/Test-LongString
	dev-perl/Test-Memory-Cycle
	dev-perl/Test-WWW-Mechanize-Catalyst
	dev-perl/Text-Markdown
	dev-perl/Text-Unaccent
	dev-perl/Text-WikiFormat
	dev-perl/Throwable
	dev-perl/XML-Parser-Lite
	dev-perl/XML-Simple
	dev-perl/XML-XPath

	perl-gcpan/CGI-Expand
	perl-gcpan/Catalyst-Plugin-Cache-HTTP
	perl-gcpan/Data-UUID-MT
	perl-gcpan/GnuPG
	perl-gcpan/HTML-HTML5-Parser
	perl-gcpan/HTML-HTML5-Sanity
	perl-gcpan/LWP-UserAgent-Mockable
	perl-gcpan/MooseX-ABC
	perl-gcpan/MooseX-Runnable
	perl-gcpan/Net-Amazon-AWSSign
	perl-gcpan/Net-Amazon-S3-Policy
	perl-gcpan/Object-InsideOut
	perl-gcpan/Plack-Middleware-Debug
	perl-gcpan/REST-Utils
	perl-gcpan/Statistics-Basic
	perl-gcpan/String-TT
	perl-gcpan/Template-Plugin-JSON-Escape
	perl-gcpan/Test-Magpie
	perl-gcpan/Test-Mock-Class
	perl-gcpan/Test-Routine
	perl-gcpan/Test-XPath
	perl-gcpan/Text-Trim
	perl-gcpan/Unicode-ICU-Collator
	perl-gcpan/RSS-Parser-Lite
	perl-gcpan/XML-SemanticDiff
"
# Deps still to have ebuilds written
#DEPEND="
	#dev-perl/local::lib

	# local::lib installs this gigantic list :-) To re-create:
	#   cd musicbrainz-server
	#   echo 'eval $( perl -Mlocal::lib )' >> ~/.bashrc
	#   source ~/.bashrc
	#   cpanm --installdeps --notest .
	# Should use MooseX::Role::Parameterized-1.02, later versions are incompatible

	# g-cpan wants to build Email-MIME for this instead
	#perl-gcpan/Email-MIME-Creator
	# g-cpan wants to build Cache for this instead
	#perl-gcpan/Cache-Memory
	# g-cpan wants to build XML-Parser-Lite for this instead
	#perl-gcpan/XML-RSS-Parser-Lite
	# g-cpan wants to build Catalyst-Runtime for this instead
	#perl-gcpan/Catalyst-Plugin-Unicode-Encoding
	# g-cpan wants to build Moose for this instead
	#perl-gcpan/Class-MOP
#"
RDEPEND="${DEPEND}"

pkg_setup() {
	# Create musicbrainz group
	enewgroup mb
	# Create musicbrainz user, put in musicbrainz group
	enewuser mb -1 -1 -1 mb
}

src_prepare() {
	# Install Node.js dependencies
	cd ${S} || die
	npm install || die

	# MusicBrainz JavaScript/CSS build system
	cd ${S}
	./node_modules/.bin/gulp || die
}

src_compile() {
	cd ${S}/postgresql-musicbrainz-unaccent
	make || die
	cd ${S}/postgresql-musicbrainz-collate
	make || die
}

src_install() {
	cd ${S}/postgresql-musicbrainz-unaccent
	make DESTDIR="${D}" install || die
	cd ${S}/postgresql-musicbrainz-collate
	make DESTDIR="${D}" install || die

	cd ${S}
	insinto /usr/share/${PN}
	doins -r * 
}

