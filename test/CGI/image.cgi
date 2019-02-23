#!/usr/bin/perl
use strict;
use warnings;
require "./WebPage.pm";

our $cgi = WebPage->new;
our $path = $cgi->getParam('path');

WebPage::sendImage($path);
