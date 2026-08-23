package com.hmgsarena.app

data class Question(
    val id: String,
    val subject: String,
    val topic: String,
    val difficulty: String,
    val question: String,
    val options: List<String>,
    val correctIndex: Int,
    val explanation: String,
    val sourceLabel: String,
    val sourceRef: String
)
