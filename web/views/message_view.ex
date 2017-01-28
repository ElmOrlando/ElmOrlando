defmodule ElmOrlando.MessageView do
  use ElmOrlando.Web, :view

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, ElmOrlando.MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, ElmOrlando.MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      name: message.name,
      message: message.message}
  end
end
