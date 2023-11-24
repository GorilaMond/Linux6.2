#!/bin/bash
# SPDX-License-Identifier: GPL-2.0


# +--------------------------------+            +-----------------------------+
# |                         vrf-h1 |            |                      vrf-h2 |
# |    + $h1                       |            | + $h2                       |
# |    | 2001:db8:1::1/64          |            | | 2001:db8:2::1/64          |
# |    | default via 2001:db8:1::3 |            | | default via 2001:db8:2::3 |
# +----|---------------------------+            +-|---------------------------+
#      |                                          |
# +----|------------------------------------------|---------------------------+
# | SW |                                          |                           |
# | +--|------------------------------------------|-------------------------+ |
# | |  + $swp1                         br1          + $swp2                 | |
# | |     vid 10 pvid untagged                         vid 20 pvid untagged | |
# | |                                                                       | |
# | |  + vx10                                       + vx20                  | |
# | |    local 2001:db8:3::1                          local 2001:db8:3::1   | |
# | |    remote 2001:db8:3::2                         remote 2001:db8:3::2  | |
# | |    id 1010                                      id 1020               | |
# | |    dstport 4789                                 dstport 4789          | |
# | |    vid 10 pvid untagged                         vid 20 pvid untagged  | |
# | |                                                                       | |
# | |                             + vx4001                                  | |
# | |                               local 2001:db8:3::1                     | |
# | |                               remote 2001:db8:3::2                    | |
# | |                               id 104001                               | |
# | |                               dstport 4789                            | |
# | |                               vid 4001 pvid untagged                  | |
# | |                                                                       | |
# | +-----------------------------------+-----------------------------------+ |
# |                                     |                                     |
# | +-----------------------------------|-----------------------------------+ |
# | |                                   |                                   | |
# | |  +--------------------------------+--------------------------------+  | |
# | |  |                                |                                |  | |
# | |  + vlan10                         |                         vlan20 +  | |
# | |  | 2001:db8:1::2/64               |               2001:db8:2::2/64 |  | |
# | |  |                                |                                |  | |
# | |  + vlan10-v (macvlan)             +             vlan20-v (macvlan) +  | |
# | |    2001:db8:1::3/64           vlan4001            2001:db8:2::3/64    | |
# | |    00:00:5e:00:01:01                             00:00:5e:00:01:01    | |
# | |                               vrf-green                               | |
# | +-----------------------------------------------------------------------+ |
# |                                                                           |
# |    + $rp1                                       +lo                       |
# |    | 2001:db8:4::1/64                           2001:db8:3::1             |
# +----|----------------------------------------------------------------------+
#      |
# +----|--------------------------------------------------------+
# |    |                            vrf-spine                   |
# |    + $rp2                                                   |
# |      2001:db8:4::2/64                                       |
# |                                                             |   (maybe) HW
# =============================================================================
# |                                                             |  (likely) SW
# |                                                             |
# |    + v1 (veth)                                              |
# |    | 2001:db8:5::2/64                                       |
# +----|--------------------------------------------------------+
#      |
# +----|----------------------------------------------------------------------+
# |    + v2 (veth)                                  +lo           NS1 (netns) |
# |      2001:db8:5::1/64                            2001:db8:3::2/128        |
# |                                                                           |
# | +-----------------------------------------------------------------------+ |
# | |                               vrf-green                               | |
# | |  + vlan10-v (macvlan)                           vlan20-v (macvlan) +  | |
# | |  | 2001:db8:1::3/64                               2001:db8:2::3/64 |  | |
# | |  | 00:00:5e:00:01:01                             00:00:5e:00:01:01 |  | |
# | |  |                            vlan4001                             |  | |
# | |  + vlan10                         +                         vlan20 +  | |
# | |  | 2001:db8:1::3/64               |               2001:db8:2::3/64 |  | |
# | |  |                                |                                |  | |
# | |  +--------------------------------+--------------------------------+  | |
# | |                                   |                                   | |
# | +-----------------------------------|-----------------------------------+ |
# |                                     |                                     |
# | +-----------------------------------+-----------------------------------+ |
# | |                                                                       | |
# | |  + vx10                                     + vx20                    | |
# | |    local 2001:db8:3::2                        local 2001:db8:3::2     | |
# | |    remote 2001:db8:3::1                       remote 2001:db8:3::1    | |
# | |    id 1010                                    id 1020                 | |
# | |    dstport 4789                               dstport 4789            | |
# | |    vid 10 pvid untagged                       vid 20 pvid untagged    | |
# | |                                                                       | |
# | |                             + vx4001                                  | |
# | |                               local 2001:db8:3::2                     | |
# | |                               remote 2001:db8:3::1                    | |
# | |                               id 104001                               | |
# | |                               dstport 4789                            | |
# | |                               vid 4001 pvid untagged                  | |
# | |                                                                       | |
# | |  + w1 (veth)                                + w3 (veth)               | |
# | |  | vid 10 pvid untagged          br1        | vid 20 pvid untagged    | |
# | +--|------------------------------------------|-------------------------+ |
# |    |                                          |                           |
# |    |                                          |                           |
# | +--|----------------------+                +--|-------------------------+ |
# | |  |               vrf-h1 |                |  |                  vrf-h2 | |
# | |  + w2 (veth)            |                |  + w4 (veth)               | |
# | |    2001:db8:1::4/64     |                |    2001:db8:2::4/64        | |
# | |    default via          |                |    default via             | |
# | |    2001:db8:1::3/64     |                |    2001:db8:2::3/64        | |
# | +-------------------------+                +----------------------------+ |
# +---------------------------------------------------------------------------+

ALL_TESTS="
	ping_ipv6
"
NUM_NETIFS=6
source lib.sh

hx_create()
{
	local vrf_name=$1; shift
	local if_name=$1; shift
	local ip_addr=$1; shift
	local gw_ip=$1; shift

	vrf_create $vrf_name
	ip link set dev $if_name master $vrf_name
	ip link set dev $vrf_name up
	ip link set dev $if_name up

	ip address add $ip_addr/64 dev $if_name
	ip neigh replace $gw_ip lladdr 00:00:5e:00:01:01 nud permanent \
		dev $if_name
	ip route add default vrf $vrf_name nexthop via $gw_ip
}
export -f hx_create

hx_destroy()
{
	local vrf_name=$1; shift
	local if_name=$1; shift
	local ip_addr=$1; shift
	local gw_ip=$1; shift

	ip route del default vrf $vrf_name nexthop via $gw_ip
	ip neigh del $gw_ip dev $if_name
	ip address del $ip_addr/64 dev $if_name

	ip link set dev $if_name down
	vrf_destroy $vrf_name
}

h1_create()
{
	hx_create "vrf-h1" $h1 2001:db8:1::1 2001:db8:1::3
}

h1_destroy()
{
	hx_destroy "vrf-h1" $h1 2001:db8:1::1 2001:db8:1::3
}

h2_create()
{
	hx_create "vrf-h2" $h2 2001:db8:2::1 2001:db8:2::3
}

h2_destroy()
{
	hx_destroy "vrf-h2" $h2 2001:db8:2::1 2001:db8:2::3
}

switch_create()
{
	ip link add name br1 type bridge vlan_filtering 1 vlan_default_pvid 0 \
		mcast_snooping 0
	# Make sure the bridge uses the MAC address of the local port and not
	# that of the VxLAN's device.
	ip link set dev br1 address $(mac_get $swp1)
	ip link set dev br1 up

	ip link set dev $rp1 up
	ip address add dev $rp1 2001:db8:4::1/64
	ip route add 2001:db8:3::2/128 nexthop via 2001:db8:4::2

	ip link add name vx10 type vxlan id 1010		\
		local 2001:db8:3::1 remote 2001:db8:3::2 dstport 4789	\
		nolearning udp6zerocsumrx udp6zerocsumtx tos inherit ttl 100
	ip link set dev vx10 up

	ip link set dev vx10 master br1
	bridge vlan add vid 10 dev vx10 pvid untagged

	ip link add name vx20 type vxlan id 1020		\
		local 2001:db8:3::1 remote 2001:db8:3::2 dstport 4789	\
		nolearning udp6zerocsumrx udp6zerocsumtx tos inherit ttl 100
	ip link set dev vx20 up

	ip link set dev vx20 master br1
	bridge vlan add vid 20 dev vx20 pvid untagged

	ip link set dev $swp1 master br1
	ip link set dev $swp1 up

	ip link set dev $swp2 master br1
	ip link set dev $swp2 up

	ip link add name vx4001 type vxlan id 104001		\
		local 2001:db8:3::1 dstport 4789			\
		nolearning udp6zerocsumrx udp6zerocsumtx tos inherit ttl 100
	ip link set dev vx4001 up

	ip link set dev vx4001 master br1
	bridge vlan add vid 4001 dev vx4001 pvid untagged

	ip address add 2001:db8:3::1/128 dev lo

	# Create SVIs
	vrf_create "vrf-green"
	ip link set dev vrf-green up

	ip link add link br1 name vlan10 up master vrf-green type vlan id 10
	ip address add 2001:db8:1::2/64 dev vlan10
	ip link add link vlan10 name vlan10-v up master vrf-green \
		address 00:00:5e:00:01:01 type macvlan mode private
	ip address add 2001:db8:1::3/64 dev vlan10-v

	ip link add link br1 name vlan20 up master vrf-green type vlan id 20
	ip address add 2001:db8:2::2/64 dev vlan20
	ip link add link vlan20 name vlan20-v up master vrf-green \
		address 00:00:5e:00:01:01 type macvlan mode private
	ip address add 2001:db8:2::3/64 dev vlan20-v

	ip link add link br1 name vlan4001 up master vrf-green \
		type vlan id 4001

	bridge vlan add vid 10 dev br1 self
	bridge vlan add vid 20 dev br1 self
	bridge vlan add vid 4001 dev br1 self

	bridge fdb add 00:00:5e:00:01:01 dev br1 self local vlan 10
	bridge fdb add 00:00:5e:00:01:01 dev br1 self local vlan 20

	bridge vlan add vid 10 dev $swp1 pvid untagged
	bridge vlan add vid 20 dev $swp2 pvid untagged
}

switch_destroy()
{
	bridge vlan del vid 20 dev br1 self
	bridge vlan del vid 10 dev br1 self

	bridge fdb del 00:00:5e:00:01:01 dev br1 self local vlan 20
	bridge fdb del 00:00:5e:00:01:01 dev br1 self local vlan 10

	bridge vlan del vid 4001 dev br1 self
	ip link del dev vlan4001

	ip link del dev vlan20

	ip link del dev vlan10

	vrf_destroy "vrf-green"

	ip address del 2001:db8:3::1/128 dev lo

	bridge vlan del vid 20 dev $swp2
	ip link set dev $swp2 down
	ip link set dev $swp2 nomaster

	bridge vlan del vid 10 dev $swp1
	ip link set dev $swp1 down
	ip link set dev $swp1 nomaster

	bridge vlan del vid 4001 dev vx4001
	ip link set dev vx4001 nomaster

	ip link set dev vx4001 down
	ip link del dev vx4001

	bridge vlan del vid 20 dev vx20
	ip link set dev vx20 nomaster

	ip link set dev vx20 down
	ip link del dev vx20

	bridge vlan del vid 10 dev vx10
	ip link set dev vx10 nomaster

	ip link set dev vx10 down
	ip link del dev vx10

	ip route del 2001:db8:3::2 nexthop via 2001:db8:4::2
	ip address del dev $rp1 2001:db8:4::1/64
	ip link set dev $rp1 down

	ip link set dev br1 down
	ip link del dev br1
}

spine_create()
{
	vrf_create "vrf-spine"
	ip link set dev $rp2 master vrf-spine
	ip link set dev v1 master vrf-spine
	ip link set dev vrf-spine up
	ip link set dev $rp2 up
	ip link set dev v1 up

	ip address add 2001:db8:4::2/64 dev $rp2
	ip address add 2001:db8:5::2/64 dev v1

	ip route add 2001:db8:3::1/128 vrf vrf-spine nexthop via \
		2001:db8:4::1
	ip route add 2001:db8:3::2/128 vrf vrf-spine nexthop via \
		2001:db8:5::1
}

spine_destroy()
{
	ip route del 2001:db8:3::2/128 vrf vrf-spine nexthop via \
		2001:db8:5::1
	ip route del 2001:db8:3::1/128 vrf vrf-spine nexthop via \
		2001:db8:4::1

	ip address del 2001:db8:5::2/64 dev v1
	ip address del 2001:db8:4::2/64 dev $rp2

	ip link set dev v1 down
	ip link set dev $rp2 down
	vrf_destroy "vrf-spine"
}

ns_h1_create()
{
	hx_create "vrf-h1" w2 2001:db8:1::4 2001:db8:1::3
}
export -f ns_h1_create

ns_h2_create()
{
	hx_create "vrf-h2" w4 2001:db8:2::4 2001:db8:2::3
}
export -f ns_h2_create

ns_switch_create()
{
	ip link add name br1 type bridge vlan_filtering 1 vlan_default_pvid 0 \
		mcast_snooping 0
	ip link set dev br1 up

	ip link set dev v2 up
	ip address add dev v2 2001:db8:5::1/64
	ip route add 2001:db8:3::1 nexthop via 2001:db8:5::2

	ip link add name vx10 type vxlan id 1010		\
		local 2001:db8:3::2 remote 2001:db8:3::1 dstport 4789	\
		nolearning udp6zerocsumrx udp6zerocsumtx tos inherit ttl 100
	ip link set dev vx10 up

	ip link set dev vx10 master br1
	bridge vlan add vid 10 dev vx10 pvid untagged

	ip link add name vx20 type vxlan id 1020		\
		local 2001:db8:3::2 remote 2001:db8:3::1 dstport 4789	\
		nolearning udp6zerocsumrx udp6zerocsumtx tos inherit ttl 100
	ip link set dev vx20 up

	ip link set dev vx20 master br1
	bridge vlan add vid 20 dev vx20 pvid untagged

	ip link add name vx4001 type vxlan id 104001		\
		local 2001:db8:3::2 dstport 4789			\
		nolearning udp6zerocsumrx udp6zerocsumtx tos inherit ttl 100
	ip link set dev vx4001 up

	ip link set dev vx4001 master br1
	bridge vlan add vid 4001 dev vx4001 pvid untagged

	ip link set dev w1 master br1
	ip link set dev w1 up
	bridge vlan add vid 10 dev w1 pvid untagged

	ip link set dev w3 master br1
	ip link set dev w3 up
	bridge vlan add vid 20 dev w3 pvid untagged

	ip address add 2001:db8:3::2/128 dev lo

	# Create SVIs
	vrf_create "vrf-green"
	ip link set dev vrf-green up

	ip link add link br1 name vlan10 up master vrf-green type vlan id 10
	ip address add 2001:db8:1::3/64 dev vlan10
	ip link add link vlan10 name vlan10-v up master vrf-green \
		address 00:00:5e:00:01:01 type macvlan mode private
	ip address add 2001:db8:1::3/64 dev vlan10-v

	ip link add link br1 name vlan20 up master vrf-green type vlan id 20
	ip address add 2001:db8:2::3/64 dev vlan20
	ip link add link vlan20 name vlan20-v up master vrf-green \
		address 00:00:5e:00:01:01 type macvlan mode private
	ip address add 2001:db8:2::3/64 dev vlan20-v

	ip link add link br1 name vlan4001 up master vrf-green \
		type vlan id 4001

	bridge vlan add vid 10 dev br1 self
	bridge vlan add vid 20 dev br1 self
	bridge vlan add vid 4001 dev br1 self

	bridge fdb add 00:00:5e:00:01:01 dev br1 self local vlan 10
	bridge fdb add 00:00:5e:00:01:01 dev br1 self local vlan 20
}
export -f ns_switch_create

ns_init()
{
	ip link add name w1 type veth peer name w2
	ip link add name w3 type veth peer name w4

	ip link set dev lo up

	ns_h1_create
	ns_h2_create
	ns_switch_create
}
export -f ns_init

ns1_create()
{
	ip netns add ns1
	ip link set dev v2 netns ns1
	in_ns ns1 ns_init
}

ns1_destroy()
{
	ip netns exec ns1 ip link set dev v2 netns 1
	ip netns del ns1
}

__l2_vni_init()
{
	local mac1=$1; shift
	local mac2=$1; shift
	local ip1=$1; shift
	local ip2=$1; shift
	local dst=$1; shift

	bridge fdb add $mac1 dev vx10 self master extern_learn static \
		dst $dst vlan 10
	bridge fdb add $mac2 dev vx20 self master extern_learn static \
		dst $dst vlan 20

	ip neigh add $ip1 lladdr $mac1 nud noarp dev vlan10 \
		extern_learn
	ip neigh add $ip2 lladdr $mac2 nud noarp dev vlan20 \
		extern_learn
}
export -f __l2_vni_init

l2_vni_init()
{
	local h1_ns_mac=$(in_ns ns1 mac_get w2)
	local h2_ns_mac=$(in_ns ns1 mac_get w4)
	local h1_mac=$(mac_get $h1)
	local h2_mac=$(mac_get $h2)

	__l2_vni_init $h1_ns_mac $h2_ns_mac 2001:db8:1::4 2001:db8:2::4 \
	       2001:db8:3::2
	in_ns ns1 __l2_vni_init $h1_mac $h2_mac 2001:db8:1::1 2001:db8:2::1 \
	       2001:db8:3::1
}

__l3_vni_init()
{
	local mac=$1; shift
	local vtep_ip=$1; shift
	local host1_ip=$1; shift
	local host2_ip=$1; shift

	bridge fdb add $mac dev vx4001 self master extern_learn static \
		dst $vtep_ip vlan 4001

	ip neigh add $vtep_ip lladdr $mac nud noarp dev vlan4001 extern_learn

	ip route add $host1_ip/128 vrf vrf-green nexthop via $vtep_ip \
		dev vlan4001 onlink
	ip route add $host2_ip/128 vrf vrf-green nexthop via $vtep_ip \
		dev vlan4001 onlink
}
export -f __l3_vni_init

l3_vni_init()
{
	local vlan4001_ns_mac=$(in_ns ns1 mac_get vlan4001)
	local vlan4001_mac=$(mac_get vlan4001)

	__l3_vni_init $vlan4001_ns_mac 2001:db8:3::2 2001:db8:1::4 \
		2001:db8:2::4
	in_ns ns1 __l3_vni_init $vlan4001_mac 2001:db8:3::1 2001:db8:1::1 \
		2001:db8:2::1
}

setup_prepare()
{
	h1=${NETIFS[p1]}
	swp1=${NETIFS[p2]}

	swp2=${NETIFS[p3]}
	h2=${NETIFS[p4]}

	rp1=${NETIFS[p5]}
	rp2=${NETIFS[p6]}

	vrf_prepare
	forwarding_enable

	h1_create
	h2_create
	switch_create

	ip link add name v1 type veth peer name v2
	spine_create
	ns1_create
	in_ns ns1 forwarding_enable

	l2_vni_init
	l3_vni_init
}

cleanup()
{
	pre_cleanup

	ns1_destroy
	spine_destroy
	ip link del dev v1

	switch_destroy
	h2_destroy
	h1_destroy

	forwarding_restore
	vrf_cleanup
}

ping_ipv6()
{
	ping6_test $h1 2001:db8:2::1 ": local->local vid 10->vid 20"
	ping6_test $h1 2001:db8:1::4 ": local->remote vid 10->vid 10"
	ping6_test $h2 2001:db8:2::4 ": local->remote vid 20->vid 20"
	ping6_test $h1 2001:db8:2::4 ": local->remote vid 10->vid 20"
	ping6_test $h2 2001:db8:1::4 ": local->remote vid 20->vid 10"
}

trap cleanup EXIT

setup_prepare
setup_wait

tests_run

exit $EXIT_STATUS
