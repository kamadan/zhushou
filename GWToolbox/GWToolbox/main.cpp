#include "stdafx.h"
#include "Defines.h"
#include "GWToolbox.h"
#include "logger.h"

#include <GWCA/Utilities/Scanner.h>

// Do all your startup things here instead.
DWORD WINAPI init(HMODULE hModule){
	__try {
		Log::InitializeLog();
		Log::Log("Waiting for logged character\n");

		GW::Scanner::Initialize();

		DWORD **found = (DWORD **)GW::Scanner::Find(
			"\xA3\x00\x00\x00\x00\xFF\x75\x0C\xC7\x05", "x????xxxxx", +1);
		if (!(found && *found)) {
			MessageBoxA(0, "We can't determine if the character is ingame.\nContact the developpers.", "GWToolbox++ - Clientside Error Detected", 0);
			FreeLibraryAndExitThread(hModule, EXIT_SUCCESS);
		} else {
			printf("[SCAN] is_ingame = %p\n", found);
		}

		DWORD *is_ingame = *found;
		while (*is_ingame == 0) {
			Sleep(100);
		}
		
		Log::Log("Creating toolbox thread\n");
		SafeThreadEntry(hModule);
	} __except ( EXCEPT_EXPRESSION_ENTRY ) {
	}
	return 0;
}

// DLL entry point, dont do things in this thread unless you know what you are doing.
BOOL WINAPI DllMain(_In_ HMODULE _HDllHandle, _In_ DWORD _Reason, _In_opt_ LPVOID _Reserved){
	DisableThreadLibraryCalls(_HDllHandle);
	if (_Reason == DLL_PROCESS_ATTACH){
		__try {
			HANDLE hThread = CreateThread(
				0,
				0,
				(LPTHREAD_START_ROUTINE)init,
				_HDllHandle,
				0,
				0);

			if (hThread != NULL)
				CloseHandle(hThread);
		} __except ( EXCEPT_EXPRESSION_ENTRY ) {
		}
	}
	return TRUE;
}
