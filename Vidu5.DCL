//=========================================//
//     DAY LA VI DU VE HOP THOAI DCL       //
//=========================================//

EXAMPLE:dialog {
	label = "DAY LA CHUONG TRINH HOLE TABLE" ;
	: column {
		: row {  // hang 1
			label = "Kieu chon kich thuoc";
			:toggle {
				label= " Chon 1 loai duong kinh " ;
				key = "StatusDuongkinhlo" ;   // ****
				value = "1" ;  
				}
			:toggle {
				label = "Chon nhieu duong kinh ";
				key = "Multi";
				value = "0" ;
				} 
			}// Finish - row1 

		:row {
			:boxed_row {
				:edit_box {
					label = "Nhap gia tri duong kinh ";
					key = "Duongkinhlo"; // ******
					value = "3.2" ;
					}
				:edit_box {
					label = "Chieu cao Name Tag : " ;
					key = "chieucaochu" ;  // *****
					value = "2.5" ; 
					}
				}
			:boxed_column {
				label = "Co xuat file .Txt hay khong ? " ;
				:toggle {
					label = "Co" ;
					key = "statustxt1" ;    //*****
					value = "0" ;
					}
				//:toggle {
				//	label ="Khong" ;
				//	key = "statustxt2" ;    // *****
				//	value = "1" ;
				//	}
				} // end boxed_column 
				
			} // Finish - row2
		:boxed_row {
			:edit_box {
				label = "Ki hieu lo ";
				key = "Nametag" ;
				value = "L" ;

				} //
			:edit_box {
				label = "Bat dau tu " ;
				key = "Beginfrom" ;
				value = "0" ;
		
				} //
			:popup_list {
				label = "Sai so la " ;
				key = "Tolerance" ;
				list = "0.0\n0.00\n0.000" ;
				}
			:popup_list {
				label = "Sap xep thu tu lo:" ;
				key = "dirsort" ;
				list = "Traiquaphai\nDuoilentren" ;
				width = 35;
				}

			} // end boxed-row

		:row { // day la hang thu 4
			:boxed_row {
				:button {
					key= "accept" ;
					label = "Chaydi " ;
					is_default = true ;
					}
				:button {
					key = "cancel" ;
					label = "Huy bo ";
					is_default = false ;
					is_cancel = true ; 
					}
				} // end -- boxed_row
			} // end -- row 4
		:boxed_row {  // Hang thong tin lien he 
			:boxed_column {
				label = "Thong tin lien he " ;
				:text {
					label = "Design by To Van Linh  " ;
					}
				:text {
					label = "Mobile : +8433 356 8236  " ;
					}
				:text {
					label = "Gstar-Tools 2021 SP1" ;
					}
				:text {
					label = "@ Copyright by Mechanic Team - RD Filter  " ;
					}
				:text {
					label = "V-ACE - ACE Antena Co,. Ltd . All rights reserved." ;
					}
				} // end boxed_column
			:popup_list {
				label = "Language" ;
				list  = "Vietnamese\nEnglish";
				}
			} // End - Hang thong tin lien he 
				
		
		} // end column

	} // end diaglog