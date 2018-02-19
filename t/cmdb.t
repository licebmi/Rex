use strict;
use warnings;

use Test::More tests => 18;

use Rex::CMDB;
use Rex::Commands;
use Rex::Commands::File;

set(
  cmdb => {
    type => "YAML",
    path => "t/cmdb",
  }
);

my $ntp = get( cmdb( "ntp", "foo" ) );
ok( $ntp->[0] eq "ntp1" && $ntp->[1] eq "ntp2",
  "got something from default.yml" );

my $name = get( cmdb( "name", "foo" ) );
is( $name, "foo", "got name from foo.yml" );

my $dns = get( cmdb( "dns", "foo" ) );
ok( $dns->[0] eq "1.1.1.1" && $dns->[1] eq "2.2.2.2",
  "got dns from env/default.yml" );

my $vhost = get( cmdb( "vhost", "foo" ) );
ok( $vhost->{name} eq "foohost" && $vhost->{doc_root} eq "/var/www",
  "got vhost from env/foo.yml" );

$ntp = undef;
$ntp = get( cmdb("ntp") );
ok( $ntp->[0] eq "ntp1" && $ntp->[1] eq "ntp2",
  "got something from default.yml" );

$dns = undef;
$dns = get( cmdb("dns") );
ok( $dns->[0] eq "1.1.1.1" && $dns->[1] eq "2.2.2.2",
  "got dns from env/default.yml" );

my $all = get( cmdb( undef, "foo" ) );
is( $all->{ntp}->[0], "ntp1",    "got ntp1 from cmdb - all request" );
is( $all->{dns}->[1], "2.2.2.2", "got dns2 from cmdb - all request" );
is( $all->{vhost}->{name}, "foohost",
  "got vhost name from cmdb - all request" );
is( $all->{name}, "foo", "got name from cmdb - all request" );

Rex::Config->set_register_cmdb_template(1);
my $content = 'Hello this is <%= $::name %>';
is(
  template( \$content, __no_sys_info__ => 1 ),
  "Hello this is defaultname",
  "get keys from CMDB"
);

is(
  template( \$content, { name => "baz", __no_sys_info__ => 1 } ),
  "Hello this is baz",
  "overwrite keys from CMDB"
);

set(
  cmdb => {
    type           => "YAML",
    path           => "t/cmdb",
    merge_behavior => 'LEFT_PRECEDENT',
  }
);

my $foo_all = get( cmdb( undef, "foo" ) );
is_deeply(
  $foo_all,
  {
    'ntp'    => [ 'ntp1',            'ntp2' ],
    'newntp' => [ 'ntpdefaultfoo01', 'ntpdefaultfoo02', 'ntp1', 'ntp2' ],
    'dns'    => [ '1.1.1.1',         '2.2.2.2' ],
    'MyTest::foo::mode' => '0666',
    'vhost'             => {
      'name'     => 'foohost',
      'doc_root' => '/var/www'
    },
    'name'   => 'foo',
    'vhost2' => {
      'name'     => 'vhost2foo',
      'doc_root' => '/var/www'
    },
    'users' => {
      'root' => {
        'password' => 'proot',
        'id'       => '0'
      },
      'user02' => {
        'password' => 'puser02',
        'id'       => '600'
      },
      'user01' => {
        'password' => 'puser01',
        'id'       => '500'
      }
    }
  },
  "DeepMerge CMDB"
);

set(
  cmdb => {
    type           => "YAML",
    path           => [
        "t/cmdb/refs/scalar.yml",
        "t/cmdb/refs/[machine.defaults].yml"
    ],
    merge_behavior => 'LEFT_PRECEDENT',
  }
);

my $bar = get cmdb 'foo';
ok($bar eq 'bar', "machine.defaults invalid: expected 'bar', got '$bar'");

set(
  cmdb => {
    type           => "YAML",
    path           => [
        "t/cmdb/refs/array.yml",
        "t/cmdb/refs/[roles].yml"
    ],
    merge_behavior => 'LEFT_PRECEDENT',
  }
);

my $role_foo = get cmdb 'role_foo';
ok($role_foo eq 'ok', "role_foo invalid: expected 'ok', got '$role_foo'");

my $role_bar = get cmdb 'role_bar';
ok($role_bar eq 'ok', "role_bar invalid: expected 'ok', got '$role_bar'");

my $role = get cmdb 'role';
ok($role eq 'foo', "role invalid (merge order invalid): expected 'foo', got '$role'");

set(
  cmdb => {
    type           => "YAML",
    path           => [
        "t/cmdb/refs/array.yml",
        "t/cmdb/refs/[roles].yml"
    ],
    merge_behavior => 'RIGHT_PRECEDENT',
  }
);

my $role = get cmdb 'role';
ok($role eq 'bar', "role invalid (merge order invalid): expected 'bar', got '$role'");
