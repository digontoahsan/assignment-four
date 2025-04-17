<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\User;
use App\Helper\JWTToken;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\File;

class UserController extends Controller
{
    public function index()
    {
        //inertia render
        return inertia('HomePage');
    }

    public function RegistrationPage()
    {
        return inertia('RegisterPage');
    }

    public function UserRegistration(Request $request)
    {
        try {
            $request->validate([
                'username' => 'required|unique:users,username',
                'email' => 'required|email|unique:users,email',
                'password' => 'required',
                'profile_pic' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg,webp|max:8192',
            ]);

            $path = 'images/default-profile.png'; // Default path

            /*if ($request->hasFile('profile_pic')) {
                $image = $request->file('profile_pic');
                $filename = uniqid() . '.' . $image->getClientOriginalExtension();
                $image->move(public_path('uploads/profile'), $filename);
                $path = 'uploads/profile/' . $filename;
            }*/
            if ($request->hasFile('profile_pic')) {
                $image = $request->file('profile_pic');
                $filename = uniqid() . '.' . $image->getClientOriginalExtension();
                $image->move(public_path('uploads/profile'), $filename);
                $path = $filename; // ✅ Save only filename
            } else {
                $path = null; // No need to save default image path in DB
            }

            User::create([
                'username' => $request->input('username'),
                'email' => $request->input('email'),
                'password' => $request->input('password'),
                'profile_pic' => $path,
            ]);

            return redirect('/login')->with('success', 'User registered successfully');
        } catch (Exception $e) {
            return redirect('/user-register')->withErrors(['message' => $e->getMessage()]);
        }
    }

    public function Login()
    {
        return inertia('LoginPage');
    }

    public function UserLogin(Request $request)
    {
        $count = User::where('email', $request->input('email'))->where('password', $request->input('password'))->select('id')->first();

        if ($count !== null) {
            // User login -> JWT token issue
            $token = JWTToken::CreateToken($request->input('email'), $count->id);

            return redirect('/dashboard')->withCookie(cookie('token', $token, 60 * 24 * 30));
        } else {
            return back()->withErrors(['message' => 'Invalid credentials!']);
        }
    }


    public function UserLogout(Request $request)
    {
        return redirect('/login')->withCookie(cookie('token', '', -1));
    }

    // public function SendOTP(Request $request)
    // {
    //     $email = $request->input('email');
    //     $otp = rand(1000, 9999);

    //     $count = User::where('email', $email)->count();

    //     if ($count == 1) {
    //         // Mail::to($email)->send(new OTPMail($otp));
    //         User::where('email', $email)->update(['otp' => $otp]);
    //         return response()->json([
    //             'status' => 'success',
    //             'message' => "4 digit {$otp} OTP sent successfully"
    //         ], 200);
    //     } else {
    //         return response()->json([
    //             'status' => 'failed',
    //             'message' => 'unauthorized'
    //         ], 200);
    //     }
    // }

    // public function VerifyOTP(Request $request)
    // {
    //     $email = $request->input('email');
    //     $otp = $request->input('otp');

    //     $count = User::where('email', $email)->where('otp', $otp)->count();

    //     if ($count == 1) {
    //         User::where('email', $email)->update(['otp' => 0]);
    //         $token = JWTToken::CreateTokenForSetPassword($request->input('email'));
    //         return response()->json([
    //             'status' => 'success',
    //             'message' => 'OTP verified successfully'
    //         ], 200)->cookie('token', $token, 60 * 24 * 30);
    //     } else {
    //         return response()->json([
    //             'status' => 'failed',
    //             'message' => 'OTP verification failed'
    //         ], 200);
    //     }
    // }

    public function ProfilePage(Request $request)
    {
        $userId = $request->header('id');

        $user = User::find($userId);

        if (!$user) {
            return redirect('/login')->withErrors(['message' => 'User not found.']);
        }

        return inertia('ProfilePage', ['user' => $user]);
    }

    public function EditProfilePage(Request $request)
    {
        $userId = $request->header('id');
        $user = User::find($userId);

        if (!$user) {
            return redirect('/login')->withErrors(['message' => 'User not found.']);
        }

        return inertia('EditProfilePage', ['user' => $user]);
    }

    public function UpdateProfile(Request $request)
    {
        $request->validate([
            'username' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'profile_pic' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:8192',
        ]);

        $userId = $request->header('id');
        $user = User::find($userId);

        if (!$user) {
            return back()->withErrors(['message' => 'User not found']);
        }

        // Handle file upload
        if ($request->hasFile('profile_pic')) {
            // Delete the old image if it's not the default one
            if ($user->profile_pic && $user->profile_pic !== 'default-profile.png') {
                $oldPath = public_path('uploads/profile/' . $user->profile_pic);
                if (File::exists($oldPath)) {
                    File::delete($oldPath);
                }
            }

            $file = $request->file('profile_pic');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('uploads/profile'), $filename);
            $user->profile_pic = $filename;
        }

        $user->username = $request->input('username');
        $user->email = $request->input('email');
        $user->save();

        return redirect('/profile')->with('success', 'Profile updated successfully.');
    }

    public function ResetPassword(Request $request)
    {
        try {
            $email = $request->header('email');
            $password = $request->input('password');
            User::where('email', $email)->update(['password' => $password]);
            return redirect('/login')->with('success', 'Password reset successfully');
        } catch (Exception $e) {
            return response()->json([
                'status' => 'failed',
                'message' => $e->getMessage()
            ]);
        }
    }

    public function ShowResetPasswordPage(Request $request)
    {
        // Get the user email from the token (set in middleware)
        $email = $request->header('email');

        // You can also fetch the user if needed
        $user = User::where('email', $email)->first();

        // Return the reset password page with user details (email in this case)
        return inertia('ResetPassword', ['user' => $user]);
    }
}
