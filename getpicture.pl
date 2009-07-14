#!/usr/bin/perl -w
# Copyright 2009, Colin Miller
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 

$fn = 0;
while($url = shift(@ARGV)) {

    $bigY = 0;

    $url =~ /cropX=(\d*\.?\d*).*cropY=(\d*\.?\d*).*cropWidth=(\d*\.?\d*)/;

    $x = $1;
    $y = $2;
    $width = $3;

    $width = $width / 2.0;
    @name = qw# UL BL UR BR  #;
    $i = 0;
    for($nx = $x ; $nx < 1; $nx += 0.5) {
	if ($nx > 0.5) {
	    $nx = 0.5;
	}
	for ($ny = $y ; $ny < 1; $ny += 0.5) {
	    if ($ny > 0.5) {
		$ny = 0.5;
	    }
	    $_ = $url;
	    s/cropX=(\d*\.?\d*)/cropX=$nx/;
	    s/cropY=(\d*\.?\d*)/cropY=$ny/;
	    s/cropWidth=(\d*\.?\d*)/cropWidth=$width/;
	    print $_ . "\n";
	    system "curl \"$_\" -o \"$name[$i++].jpg\"";
	}
    }

    system "montage UL.jpg UR.jpg BL.jpg BR.jpg -geometry +0+0 picture$fn.jpg";
    $fn++;
}
