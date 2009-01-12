#ifndef P7142_H_
#define P7142_H_

#include <string>

namespace Pentek {
	
	class p7142 {
		
		public:
			/// Constructor,
			/// @param devName The top level device name (e.g. 
			/// /dev/pentek/p7140/0. Other device names, suchc
			/// as ctrl or dn/0 will be constructed as needed.
			/// The ctrl device will be accessed in order to verify
			/// that the card is available. Use isOkay() to verify
			/// that it is.
			p7142(std::string devName);
			/// Destructor.
			virtual ~p7142();
			/// @return true if the last operation was succesfull,
			/// false otherwise.
			bool ok();
			
		protected:
			/// Indicated the success of the last operation.
			bool _ok;
			/// The root device name
			std::string _devName;
			/// The ctrl device name
			std::string _devCtrl;
	};
	
}

#endif /*P7142_H_*/
