// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.addfluttertoandroid

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.annotation.NonNull
import android.support.design.widget.BottomNavigationView
import android.support.v4.app.Fragment
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.TextView
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import kotlinx.android.synthetic.main.activity_main.*
import android.view.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterView


class MainActivity : AppCompatActivity() {

    private val mOnNavigationItemSelectedListener = BottomNavigationView.OnNavigationItemSelectedListener { item ->
        when (item.itemId) {
            R.id.navigation_home -> {
                addFragment("I am an Android Fragment!!!")
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_dashboard -> {
                addFragment("I am a second Android Fragment!!!")
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_notifications -> {
                addFlutterFragment()
                return@OnNavigationItemSelectedListener true
            }
        }
        false
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main_linear)
        addFragment("I am an Android Fragment!!!")
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.action_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem) = when (item.itemId) {
        R.id.action_favorite -> {
            Log.i("onCreate", "Menu item selected")
            launchFlutterActivity()
            true
        }
        else -> {
            super.onOptionsItemSelected(item)
        }
    }

    private fun addFragment(text: String) {
        supportFragmentManager
            .beginTransaction()
            .replace(R.id.fragment_container,
                AndroidFragment.newInstance(text))
            .commit()
    }


    private fun addFlutterFragment() {
        supportFragmentManager.beginTransaction()
            .replace(R.id.fragment_container,
                MyFlutterFragment.newInstance())
            .commit()
    }

    private fun launchFlutterActivity() =
        startActivity(Intent(this, MyFlutterActivity::class.java))

}

class AndroidFragment : Fragment() {

    companion object {
        fun newInstance(text: String): AndroidFragment {
            val fragment = AndroidFragment()
            val args = Bundle()
            args.putString("text", text)
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_main, container, false)
        arguments?.getString("text").let {
            view.findViewById<TextView>(R.id.fragment_message).setText(it)
        }
        return view
    }
}

class MyFlutterFragment : FlutterFragment() {

    companion object {
        @JvmStatic
        fun newInstance() =
            MyFlutterFragment().apply {
                return FlutterFragment.Builder(MyFlutterFragment::class.java)
                    .renderMode(FlutterView.RenderMode.surface)
                    .transparencyMode(FlutterView.TransparencyMode.transparent)
                    .build<MyFlutterFragment>()
            }
    }

    override fun createFlutterEngine(@NonNull context: Context): FlutterEngine =
         (context.applicationContext as MyApplication).engine


    override fun retainFlutterEngineAfterFragmentDestruction() = true
}

class MyFlutterActivity : FlutterActivity(), FlutterFragment.FlutterEngineProvider {

    override fun getFlutterEngine(context: Context): FlutterEngine? =
        (context.applicationContext as MyApplication).engine

}