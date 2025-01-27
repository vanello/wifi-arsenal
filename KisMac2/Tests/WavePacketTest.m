/*
<<<<<<< 651cabc6a59177b5257d540dbc8b5321710c46ca
 
 File:			WavePacketTest.h
 Program:		KisMAC
 Author:		Michael Roßberg
                mick@binaervarianz.de
 Changes:       Vitalii Parovishnyk(1012-2015)
 
 Description:	KisMAC is a wireless stumbler for MacOS X.
 
 This file is part of KisMAC.
 
 Most parts of this file are based on aircrack by Christophe Devine.
 
 KisMAC is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License, version 2,
 as published by the Free Software Foundation;
 
 KisMAC is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with KisMAC; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

=======
        
        File:			WavePacketTest.m
        Program:		KisMAC
		Author:			Michael Rossberg
						mick@binaervarianz.de
		Description:	KisMAC is a wireless stumbler for MacOS X.
                
        This file is part of KisMAC.

    KisMAC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License, version 2,
    as published by the Free Software Foundation;

    KisMAC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with KisMAC; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/
>>>>>>> Merge branch 'master' of https://github.com/0x90/wifi-arsenal
#import "WavePacket.h"
#import "WaveHelper.h"
#import "80211b.h"

@implementation WavePacket(UnitTestExtentsion)

- (void) testProbeRequest {
	WLFrame *f;
	UInt8 frame[] = "\x40\x00\x00\x00\xff\xff\xff\xff\xff\xff\x00\x0d\x93\x86\x5f\xaa\xff\xff\xff\xff\xff\xff\x00\x8b\x00\x00\x01\x08\x02\x04\x0b\x16\x24\x30\x48\x6c\x32\x04\x0c\x12\x18\x60";
	[self parseFrame: frame];
	
	UKIntsEqual(0, [self type]);
	UKFalse([self toDS]);
	UKFalse([self fromDS]);
	UKIntsEqual(18, [self bodyLength]);
	UKIntsEqual(IEEE80211_SUBTYPE_PROBE_REQ, [self subType]);
	UKStringsEqual(@"<no bssid>", [self BSSIDString]);
	UKStringsEqual(@"00:0D:93:86:5F:AA", [self stringSenderID]);
	UKStringsEqual(@"FF:FF:FF:FF:FF:FF", [self stringReceiverID]);
}

- (void) testBeaconFrame {
	WLFrame *f;
	UInt8 frame[] = "\x80\x00\x00\x00\xff\xff\xff\xff\xff\xff\x00\x0f\xf7\xb6\x58\xb0\x00\x0f\xf7\xb6\x58\xb0\x80\x37\x0e\x63\x6c\x60\x00\x00\x00\x00\x64\x00\x01\x04\x00\x0b\x44\x46\x4e\x5f\x52\x6f\x61\x6d\x69\x6e\x67\x01\x08\x82\x84\x8b\x0c\x12\x96\x18\x24\x03\x01\x09\x05\x04\x00\x02\x00\x00\x2a\x01\x02\x32\x04\x30\x48\x60\x6c\x85\x1e\x00\x00\x84\x00\x0f\x00\xff\x03\x01\x00\x61\x70\x32\x33\x2d\x61\x68\x7a\x66\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x25\xdd\x18\x00\x50\xf2\x02\x01\x01\x0c\x00\x03\xa4\x00\x00\x27\xa4\x00\x00\x42\x43\x5e\x00\x62\x32\x2f\x00\xdd\x16\x00\x40\x96\x04\x00\x0c\x07\xa4\x00\x00\x23\xa4\x00\x00\x42\x43\x00\x00\x62\x32\x00\x00\xdd\x05\x00\x40\x96\x03\x02\xdd\x13\x00\x50\xf2\x05\x00\x01\x00\x00\x00\x00\x10\x07\x56\x50\x4e\x2f\x57\x45\x42";
	[self parseFrame: frame];
	
	UKIntsEqual(0, [self type]);
	UKFalse([self toDS]);
	UKFalse([self fromDS]);
	UKIntsEqual(163, [self bodyLength]);
	UKIntsEqual(IEEE80211_SUBTYPE_BEACON, [self subType]);
	UKStringsEqual(@"00:0F:F7:B6:58:B0", [self BSSIDString]);
	UKStringsEqual(@"00:0F:F7:B6:58:B0", [self stringSenderID]);
	UKStringsEqual(@"FF:FF:FF:FF:FF:FF", [self stringReceiverID]);
	UKStringsEqual(@"DFN_Roaming", [self SSID]);
	
}

- (void) testSSIDList {
	WLFrame *f;
	UInt8 frame[] = "\x80\x00\x00\x00\xff\xff\xff\xff\xff\xff\x00\x12\xda\x9e\x85\xd0\x00\x12\xda\x9e\x85\xd0\xa0\x77\x8f\x91\xc9\x00\x00\x00\x00\x00\x64\x00\x21\x04\x00\x07\x61\x68\x7a\x66\x6e\x65\x74\x01\x08\x82\x84\x8b\x0c\x12\x96\x18\x24\x03\x01\x0d\x05\x04\x01\x02\x00\x00\x2a\x01\x02\x32\x04\x30\x48\x60\x6c\x85\x1e\x00\x00\x84\x00\x0f\x00\xff\x03\x01\x00\x61\x70\x33\x2d\x6b\x68\x62\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x25\xdd\x18\x00\x50\xf2\x02\x01\x01\x08\x00\x03\xa4\x00\x00\x27\xa4\x00\x00\x42\x43\x5e\x00\x62\x32\x2f\x00\xdd\x16\x00\x40\x96\x04\x00\x08\x07\xa4\x00\x00\x23\xa4\x00\x00\x42\x43\x00\x00\x62\x32\x00\x00\xdd\x05\x00\x40\x96\x03\x02\xdd\x29\x00\x50\xf2\x05\x02\x02\x00\x00\x00\x00\x10\x0d\x62\x69\x6e\x61\x65\x72\x76\x61\x72\x69\x61\x6e\x7a\x00\x00\x00\x00\x10\x0a\x74\x75\x69\x6c\x61\x6e\x64\x6f\x77\x6e";
	[self parseFrame: frame];
	
	UKIntsEqual(0, [self type]);
	UKFalse([self toDS]);
	UKFalse([self fromDS]);
	UKIntsEqual(IEEE80211_SUBTYPE_BEACON, [self subType]);
	UKIntsEqual(181, [self bodyLength]);
	UKIntsEqual(2, [[self SSIDs] count]);
	UKStringsEqual(@"binaervarianz", [[self SSIDs] objectAtIndex:0]);
	UKStringsEqual(@"00:12:DA:9E:85:D0", [self BSSIDString]);
	UKStringsEqual(@"00:12:DA:9E:85:D0", [self stringSenderID]);
	UKStringsEqual(@"FF:FF:FF:FF:FF:FF", [self stringReceiverID]);
	UKStringsEqual(@"ahzfnet", [self SSID]);
}

- (void) testWPAData {
	WLFrame *f;
	UInt8 frame[] = "\x08\x41\xd5\x00\x00\x11\x24\x08\xe2\x8b\x00\x30\x65\x1b\xf0\x86\x00\xe0\x7d\xb2\x1e\x95\x30\x3a\x02\x22\xd0\x20\x00\x00\x00\x00\x76\xac\x64\x73\x16\x7d\xb9\x25\x59\xac\x03\x59\x99\xaf\x81\xec\xb6\x72\xed\xd3\x31\xaf\xc7\x63\xb1\x60\x7d\x37\x1f\xf3\x31\x3a\x3d\x03\x39\xa6\x97\x76\xa4\xbf\xa5\x3d\x15\xe0\x2e\xab\xdb\xe8\xdb\x17\x43\x95\xa6\x34\x28\xd9\x97\x21\x55\x1f";
	[self parseFrame: frame];
	
	UKIntsEqual(IEEE80211_TYPE_DATA, [self type]);
	UKTrue([self toDS]);
	UKFalse([self fromDS]);
	UKIntsEqual(68, [self bodyLength]);
	UKIntsEqual(encryptionTypeWPA, [self wep]);
	UKStringsEqual(@"00:11:24:08:E2:8B", [self BSSIDString]);
	UKStringsEqual(@"00:30:65:1B:F0:86", [self stringSenderID]);
	UKStringsEqual(@"00:E0:7D:B2:1E:95", [self stringReceiverID]);
}

@end
