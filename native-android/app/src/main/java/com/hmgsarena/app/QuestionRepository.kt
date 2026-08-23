package com.hmgsarena.app

import android.content.Context
import org.json.JSONArray

object QuestionRepository {
    fun load(context: Context): List<Question> {
        val json = context.assets.open("questions_seed.json").bufferedReader().use { it.readText() }
        val root = JSONArray(json)
        return buildList {
            for (i in 0 until root.length()) {
                val o = root.getJSONObject(i)
                val opts = o.getJSONArray("options")
                val options = buildList { for (j in 0 until opts.length()) add(opts.getString(j)) }
                add(
                    Question(
                        id = o.getString("id"),
                        subject = o.getString("subject"),
                        topic = o.getString("topic"),
                        difficulty = o.getString("difficulty"),
                        question = o.getString("question"),
                        options = options,
                        correctIndex = o.getInt("correctIndex"),
                        explanation = o.optString("explanation"),
                        sourceLabel = o.optString("sourceLabel"),
                        sourceRef = o.optString("sourceRef")
                    )
                )
            }
        }
    }
}
